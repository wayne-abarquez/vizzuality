<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:georss="http://www.georss.org/georss" version="2.0">
<channel>
<title>Próximas carreras en runnity.com</title>
<copyright>Copyright retained by original author, refer to http://www.runnity.com/ for further information</copyright>
<webMaster>jatorre@runnity.com</webMaster>
<link>http://runnity.com/</link>
<description>Español</description>
<language>es-es</language>
<pubDate>{$smarty.now|date_format:'%Y-%m-%dT%H:%M:%SZ'}</pubDate>
<generator>Runnity.com http://runnity.com/</generator>
{foreach key=id item=run from=$runs}
<item>
<title>{$run.name}, {$run.event_date}, {$run.event_location}</title>
<link>http://runnity.com/carrera.php?id={$run.id}</link>
<description>{$run.description}</description>
<author>Runnity.com</author>
<category>Carreras</category>
<pubDate>{$run.created_when}</pubDate>
<guid>http://runnity.com/carrera.php?id={$run.id}</guid>
<georss:point>{$run.start_point_lat},{$run.start_point_lon}</georss:point>
<comments>http://runnity.com/carrera.php?id={$run.id}#comments</comments>
</item>
{/foreach}
</channel>
</rss>
