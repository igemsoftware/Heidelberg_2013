# Scrapy settings for Heartbeat project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/topics/settings.html
#

import re

BOT_NAME = 'Heartbeat'
BOT_VERSION = '1.0'

SPIDER_MODULES = ['Heartbeat.spiders']
NEWSPIDER_MODULE = 'Heartbeat.spiders'
#USER_AGENT = '%s/%s' % (BOT_NAME, BOT_VERSION)
HTTPCACHE_ENABLED = False
#COOKIES_ENABLED = False
COOKIES_DEBUG = True

ITEM_PIPELINES = ['Heartbeat.pipelines.HeartbeatPipeline']

# Team.cgi works extensively with cookies
#CONCURRENT_ITEMS = 1
#CONCURRENT_REQUESTS_PER_DOMAIN = 1
DUPEFILTER_CLASS = 'scrapy.dupefilter.BaseDupeFilter'

LOG_LEVEL='INFO'

YEARS = [2007, 2008, 2009, 2010, 2011, 2012]
TEAM_LIST = "http://igem.org/Team_List?year=%d"
RESULTS = "http://igem.org/Results?year=%d&region=All&division=igem"
PARTSREGISTRY_PART_FORMAT = "%s%06d"
PARTSREGISTRY_PART = "http://parts.igem.org/das/parts/features/?segment=%s"

BIOBRICK_PATTERN = re.compile("^(BBa_[A-Za-z])(\d+)$")

SPIDERS = ['ResultSpider','TeamSpider']
YEAR_SPIDERS = {2007: 'ResultSpider2007'}
