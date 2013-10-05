from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector
from scrapy.http import Request

from Heartbeat.items import ResultItem

class ResultSpider2007(BaseSpider):
    name = 'ResultSpider2007'
    start_urls = ['http://2007.igem.org/Results']
    def __init__(self):
        BaseSpider.__init__(self)
        self.seenTeams = dict()

    def parse(self, response):
        hxs = HtmlXPathSelector(response)
        year = 2007
        resultstable = hxs.select("//div[@id='awardtable']/table/tr[1]")
        awardtable = resultstable.select(".//table[@class='results']")
        grandprize = awardtable.select("tr[@class='grandprize']")
        item = ResultItem()
        item['year'] = year
        item['name'] = self.mkName(grandprize.select("td[2]/text()").extract()[0])
        item['awards_championship'] = [grandprize.select("td[1]/text()").extract()[0]]
        self.seenTeams[item['name']] = item
        for f in grandprize.select("(following-sibling::*)[1]//table//td/text()").extract()[0]:
            try:
                self.seenTeams[f]['awards_championship'].append("Finalist")
            except KeyError:
                item = ResultItem()
                item['year'] = year
                item['name'] = self.mkName(f)
                item['awards_championship'] = ["Finalist"]
                self.seenTeams[f] = item
        for f in grandprize.select("following-sibling::*[@class='extras' or @class='tracks']"):
            data = f.select("td/text()").extract()
            try:
                self.seenTeams[data[1]]['awards_championship'].append(data[0])
            except KeyError:
                item = ResultItem()
                item['year'] = year
                item['name'] = self.mkName(data[1])
                item['awards_championship'] = [data[0]]
                self.seenTeams[data[1]] = item
        medals = resultstable.select("td[2]/p/text()").extract()
        medalteams = resultstable.select("td[2]/table")
        for i in xrange(len(medals)):
            medal = medals[i].split(" ")[0]
            teams = medalteams[i].select(".//td/text()").extract()
            for t in teams:
                if len(t) > 1:
                    try:
                        item = self.seenTeams[t]
                    except KeyError:
                        item = ResultItem()
                        item['year'] = year
                        item['name'] = self.mkName(t)
                    item['medal'] = medal
                    yield item

    def mkName(self, team):
        return team.replace("-", "_")
