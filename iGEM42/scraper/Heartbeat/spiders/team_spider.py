from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector, XmlXPathSelector
from scrapy.http import Request

from Heartbeat.items import TeamItem

class TeamSpider(BaseSpider):
    name = 'TeamSpider'

    def __init__(self):
        BaseSpider.__init__(self)
        self.seenTeams = set() # avoid duplicates when teams are listed both for continent and championship

    def start_requests(self):
        self.pattern = self.crawler.settings['BIOBRICK_PATTERN']
        self.part_format = self.crawler.settings['PARTSREGISTRY_PART_FORMAT']
        for year in self.crawler.settings['YEARS']:
            yield self.make_requests_from_url(self.crawler.settings['TEAM_LIST'] % year)

    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        teamtables = hxs.select("//table[starts-with(@id, 'table_Teams_from_')]")
        for url in teamtables.select(".//a/@href").extract():
            yield Request(url, callback=self.parseTeam, meta={'url': url, 'cookiejar': url})

    def parseTeam(self, response):
        if response.meta['url'] not in self.seenTeams:
            hxs = HtmlXPathSelector(response)
            item = TeamItem()
            item['year'] = int(hxs.select("//h1[@class='firstHeading']/text()").re("IGEM (\d{4})")[0])
            item['name'] = hxs.select("//table[@id='table_info']/tr[1]/td[2]/text()").extract()[0].replace("_", " ")
            item['region'] = hxs.select("//table[@id='table_info']/tr[td[1]/text()='Region:']/td[2]/text()").extract()[0].strip()
            item['project'] = "".join(hxs.select("//table[@id='table_abstract']/tr[1]/td[1]//text()").extract()).strip()
            item['abstract'] = "".join(hxs.select("//table[@id='table_abstract']/tr[2]/td[1]//text()").extract()).strip()
            track = hxs.select("//table[@id='table_tracks']//td/text()").extract()[0].strip()
            if track.startswith("Assigned Track:"):
                item['track'] = track[15:].strip()
            item['instructors'] = hxs.select("//table[@id='table_roster'][1]//tr/td[2]/text()").extract()
            item['students'] = hxs.select("//table[@id='table_roster'][2]//tr/td[2]/text()").extract()
            item['advisors'] = hxs.select("//table[@id='table_roster'][3]//tr/td[2]/text()").extract()
            item['url'] = response.meta['url'] # can't use response.url due to redirect
            item['wiki'] = hxs.select("//table[@id='table_info']/tr[1]/td[2]/div/a[1]/@href").extract()[0]
            item['parts_range'] = hxs.select("//table[@id='table_ranges']//span/text()").re("(BBa_[^\s]+) to (BBa_[^\s]+)")
            item['parts'] = []

            self.seenTeams.add(item['url'])

            if len(item['parts_range']) == 0:
                yield item
            else:
                subids = [self.pattern.match(item['parts_range'][0]), self.pattern.match(item['parts_range'][1])]
                if subids[0].group(1) != subids[1].group(1):
                    raise BaseException("Incompatible BioBrick range!")
                else:
                    start = int(subids[0].group(2))
                    yield self.makePartRequest(subids[0].group(1), start, item, int(subids[1].group(2)))
                    #yield Request(self.crawler.settings['PARTSREGISTRY_PART'] % (self.part_format % (subids[0].group(1), start)), callback=self.parsePart, meta={'item': item, 'part_num': start, 'end_range': int(subids[1].group(2)), 'part_prefix': subids[0].group(1)})

    def parsePart(self, response):
        item = response.meta['item']
        xxs = XmlXPathSelector(response)
        if len(xxs.select("//ERRORSEGMENT")) == 0:
            part_num = response.meta['part_num']
            end_range = response.meta['end_range']
            part_prefix = response.meta['part_prefix']
            item['parts'].append(self.part_format % (part_prefix, part_num))
            if part_num < end_range:
                yield self.makePartRequest(part_prefix, part_num + 1, item, end_range)
            else:
                yield item
        else:
            yield item

    def makePartRequest(self, prefix, num, item, end):
        return Request(self.crawler.settings['PARTSREGISTRY_PART'] % (self.part_format % (prefix, num)), callback=self.parsePart, meta={'item': item, 'part_num': num, 'end_range': end, 'part_prefix': prefix})
