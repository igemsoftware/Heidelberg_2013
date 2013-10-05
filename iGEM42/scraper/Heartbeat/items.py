# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/topics/items.html

from scrapy.item import Item, Field

class HeartbeatItem(Item):
    year = Field()
    name = Field()

class TeamItem(HeartbeatItem):
    region = Field()
    project = Field()
    abstract = Field()
    track = Field()
    instructors = Field()
    students = Field()
    advisors = Field()
    url = Field()
    wiki = Field()
    parts_range = Field()
    parts = Field()

class ResultItem(HeartbeatItem):
    medal = Field()
    awards_regional = Field()
    awards_championship = Field()

class PartsList(Item):
    parts = Field()
