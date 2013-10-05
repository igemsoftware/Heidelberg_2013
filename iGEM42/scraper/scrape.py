#!/usr/bin/env python

from optparse import OptionParser

from twisted.internet import reactor
from scrapy.crawler import Crawler
from scrapy.settings import Settings
from scrapy import signals
from scrapy.utils.project import inside_project, get_project_settings
from scrapy import log

parser = OptionParser()
parser.add_option("-o", "--outfile", dest="outfile", help="Write JSON output to FILE", metavar="FILE", default="-")

options = parser.parse_args()[0]

settings = get_project_settings()
settings.overrides['OUTFILE'] = options.outfile

spiders = 0

def crawler_started():
    global spiders
    spiders += 1

def crawler_stopped():
    global spiders
    spiders -= 1
    if spiders == 0:
        reactor.stop()

def setupCrawler(spider):
    crawler = Crawler(settings)
    crawler.configure()
    crawler.signals.connect(crawler_started, signals.engine_started)
    crawler.signals.connect(crawler_stopped, signals.engine_stopped)
    crawler.crawl(crawler.spiders.create(spider))
    crawler.start()

for spider in settings['SPIDERS']:
    setupCrawler(spider)

if (settings.getbool('LOG_ENABLED')):
    log.start(settings['LOG_FILE'], settings['LOG_LEVEL'], settings['LOG_STDOUT'],
    settings['LOG_ENCODING'])

reactor.run() # the script will block here
