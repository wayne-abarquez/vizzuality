<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:georss="http://www.georss.org/georss" version="2.0">
<channel>
<title>{$titulo}</title>
<copyright>Copyright retained by original author, refer to http://www.runnity.com/ for further information</copyright>
<webMaster>jatorre@runnity.com</webMaster>
<link>http://www.runnity.com/</link>
<description>Español</description>
<language>es-es</language>
<pubDate>{$smarty.now|date_format:'%Y-%m-%dT%H:%M:%SZ'}</pubDate>
<generator>Runnity.com http://www.runnity.com/</generator>
{foreach key=id item=run from=$results}
<item>
<title>{$run.name}, {$run.event_date}, {$run.event_location}</title>
<link>http://www.runnity.com/run/{$run.id}/{$run.name|seourl}</link>
<description>{$run.description}</description>
<author>Runnity.com</author>
<category>Carreras</category>
<pubDate>{$run.created_when}</pubDate>
<guid>http://www.runnity.com/run/{$run.id}/{$run.name|seourl}</guid>
<georss:point>{$run.start_point_lat},{$run.start_point_lon}</georss:point>
<comments>http://www.runnity.com/run/{$run.id}/{$run.name|seourl}#comments</comments>
</item>
{/foreach}
</channel>
</rss>
