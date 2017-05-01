---
layout: post
title: Watering and draining planets
published: true
---
What the Earth would look like if the sea level suddenly changed? 
And what would be the Moon, Mars and Venus with as much water as on the Earth?
Show this on the following maps and compare our Earth with other 
astronomical objects.


<strong>World maps.</strong> On this first map, you can show how the
world would be if the sea level increased by +100m.
![100m increase of the sea level]({{site.baseurl}}/images/2014-1-11-Topography/world100.png) 

On this second map, the sea level increased by +1000m.
![1000m increase of the sea level]({{site.baseurl}}/images/2014-1-11-Topography/world1000.png) 

You can browse many other (positive or negative) sea level shifts <a href="https://github.com/ahstat/topography/tree/master/outputs/world/outputs1920">here</a>.

Note that the maps are bedrock, i.e. without any ice surface. That's why
<a href="http://nsidc.org/data/atlas/news/bedrock_elevation.html" target="_blank">Antarctica forms several islands</a> 
and 
<a title="Greenland ice sheet and bedrock" href="http://en.wikipedia.org/wiki/Greenland_ice_sheet" target="_blank">a hole is on the center of Greenland</a>.

[The map associated with a fall of 100m]({{site.baseurl}}/images/2014-1-11-Topography/world-100.png) 
of the sea level might represent <a title="Post glacial sea level rise" href="http://commons.wikimedia.org/wiki/File:Post-Glacial_Sea_Level.png" target="_blank">the bedrock Earth 18000 years ago</a> (ignoring the plate tectonic effects). On that map, you can observe that Russia and USA merge together, as the United Kingdom with mainland Europe.
For comparison, if all the ice melted on the Earth, the sea level would 
[increase by 60m]({{site.baseurl}}/images/2014-1-11-Topography/world60.png) 

<strong>Celestial objects maps.</strong> On the following maps, we can see the Moon, 
Venus and Mars with about 70% of their surface covered by water.

*The Moon*
![The Moon with about 70% of the surface covered by water]({{site.baseurl}}/images/2014-1-11-Topography/moon305.png) 
The Moon is full of craters, and strangely the far side (on the center of the map)
is higher than the near side (on the right and on the left).

*Venus*
![Venus with about 70% of the surface covered by water]({{site.baseurl}}/images/2014-1-11-Topography/venus965.png) 
Venus is a quite flat planet, except on <a title="Ishtar Terra wiki page" href="http://en.wikipedia.org/wiki/Ishtar_Terra" target="_blank">Ishtar Terra</a> (on the north) and on <a title=" Aphrodite Terra wiki page" href="http://en.wikipedia.org/wiki/Aphrodite_Terra" target="_blank">Aphrodite Terra</a> (on the right on the map).

*Mars*
![Mars with about 70% of the surface covered by water]({{site.baseurl}}/images/2014-1-11-Topography/mars1436.png) 
We can observe the remarkable Martian dichotomy and find:
<ul>
	<li>the <a title="Valles Marineris wiki page" href="http://en.wikipedia.org/wiki/Valles_Marineris" target="_blank">Valles Marineris</a> canyon on the right of the map (near the <a title="Tharsis volcanic plateau wiki page" href="http://en.wikipedia.org/wiki/Tharsis" target="_blank">Tharsis volcanic plateau</a>),</li>
	<li>the <a title="Olympus Mons wiki page" href="http://en.wikipedia.org/wiki/Olympus_Mons" target="_blank">Olympus Mons</a>, an alone snow-covered island close to Tharsis,</li>
	<li>the <a title="Hellas Planitia wiki page" href="http://en.wikipedia.org/wiki/Hellas_Planitia" target="_blank">Hellas Planitia</a> impact crater on the left of the map.</li>
</ul>

**Related posts**
<ul>
	<li><a title="Flood simulation" href="http://flood.firetree.net/" target="_blank">Flood simulation from 0m to 60m</a> and the related <a title="Flood simulation blog post" href="http://blog.firetree.net/2006/05/18/more-about-flood-maps/" target="_blank">blog post</a>.</li>
	<li><a title="If all the ice melted" href="http://ngm.nationalgeographic.com/2013/09/rising-seas/if-ice-melted-map" target="_blank">If all the ice melted</a> from National Geographic.</li>
	<li>Topographic map of Titan (moon of Saturne) <a title="Hypsometry of Titan" href="http://www.sciencedirect.com/science/article/pii/S0019103510003817" target="_blank">here</a> and <a title="Topographic map of Titan" href="http://www.jpl.nasa.gov/news/news.php?release=2013-161" target="_blank">here</a>.</li>
</ul>

<hr />

How to make those plots? I proceed in five steps.
<ol>
	<li>Get the data</li>
	<li>Transform it to raw files (with <a title="Official GDAL page" href="http://www.gdal.org/" target="_blank">gdal</a>)</li>
	<li>Files are big, reduce them (with the stream editors <a title="Official sed page" href="http://www.gnu.org/software/sed/" target="_blank">sed</a> and awk)</li>
	<li>Plot data (with <a title="Official R page" href="http://www.r-project.org/" target="_blank">R</a>)</li>
	<li>Make html (using a <a title="Coin Slider page" href="http://workshop.rs/projects/coin-slider/" target="_blank">jQuery slider</a>)</li>
</ol>
<p lang="en"><strong>Get the data.</strong> I get topographic data of the Earth from the NOAA website (see <a title="Main page to download datafiles" href="http://www.ngdc.noaa.gov/mgg/global/global.html" target="_blank">this</a>, <a title="Page to dowload lower resolution topographic maps" href="http://www.ngdc.noaa.gov/mgg/gdas/gd_designagrid.html" target="_blank">this</a> and <a title="Page to dowload custom grids using the mouse" href="http://maps.ngdc.noaa.gov/viewers/wcs-client/" target="_blank">this</a>). I took the bedrock file version with xyz grid format and 10' cell size. For the Moon, I find data from the <a title="Get Moon data" href="http://www.miz.nao.ac.jp/rise-pub/en/content/pub-data/topo_grid" target="_blank">NAOJ website</a> (you have to create a free account before downloading). For Venus, you can pick the file <a title="Get Venus data" href="http://math.univ-lyon1.fr/homes-www/huet/documents/2-topography/Magellan_GTDR.grd.bz2" target="_blank">here</a>. Finally, for Mars, data are available on the <a title="Get Mars data" href="http://pds-geosciences.wustl.edu/missions/mgs/megdr.html" target="_blank">MOLA subsite</a> of the NASA (I took megt90n000cb img and lbl files). I didn't find any data for Mercury (I would be grateful if someone could send it to me).</p>
<p lang="en"><strong>Transform it to text files.</strong> Some files are not in raw text files, i.e. some files cannot be open directly with a text editor. Those are Mars and Venus data files, which have respectively ".img" and ".grd" filename extensions. I convert them into xyz files, i.e. text files with on each line the longitude, the latitude and the height. Thanks to <a title="Post asking how to convert img to xyz files" href="http://geoweb.rsl.wustl.edu/community/index.php?/topic/236-opening-img-binary-files-bis/" target="_blank">K.J. Bennett</a>, I was able to do this with the gdal-bin package and the following line code.</p>

Use `git status` to list all new or modified files that haven't yet been committed.

Some basic Git commands are:
```
git status
git add
git commit
```

<blockquote>
<pre style="text-align: center;">gdal_translate -of XYZ megt90n000cb.lbl megt90n000cb.txt</pre>
</blockquote>

<blockquote>
gdal_translate -of XYZ megt90n000cb.lbl megt90n000cb.txt
</blockquote>

<pre style="text-align: center;">gdal_translate -of XYZ megt90n000cb.lbl megt90n000cb.txt</pre>

```
gdal_translate -of XYZ megt90n000cb.lbl megt90n000cb.txt
```
<p lang="en"><strong>Files are big, reduce them. </strong>On my personal computer, it is difficult to manage text files with a size greater than 100 MB. Here, the data files for Venus and the Moon are respectively 1.5 GB and 500 MB. To read them, I reduce them by taking only some lines. I take the Moon data file as an example. I work here under Linux, but the following can be adapted in other operating systems. To read the beginning of the file, I use the "head" command:</p>

```
head -30000 lalt_topo_ver3.grd.txt &gt;firstLines.txt
```

I observe that there is 5760 lines for each latitude, then using the "split" command,

```
split -d -l5760 -a4 lalt_topo_ver3.grd.txt
```

I show that the data consider 5760<b>×</b>2880 lines.
<p lang="en">Then, I delete every two lines with sed:</p>

```
sed 'n;d' lalt_topo_ver3.grd.txt &gt;moon1-0.txt
```

<p lang="en">The new file has now 2880<b>×</b>2880 lines.</p>
Next, to delete m lines every 2m with m=2880, I run this awk script (thanks to <a title="How to delete m lines every 2m" href="http://www.commentcamarche.net/forum/affich-27923467-suppression-de-m-lignes-modulo-2m-avec-sed" target="_blank">dubcek</a>):

```
m=2880; awk -v m=$m '!((NR-1)%m) {n=!n} !n' moon1-0.txt &gt;moon1-1.txt
```

<p lang="en">I finally obtain a readable 2880<b>×</b>1440 lines file.</p>
<p lang="en"><strong>Plot data and make html. </strong><span style="color: #000000;">I use R and the functions "contour" and "filled.contour" to plot data. The R file is available <a title="R plotting file" href="http://math.univ-lyon1.fr/homes-www/huet/documents/2-topography/topography-global.R" target="_blank">here</a>. Notice that for those plots, I take the <a title="Wikipedia conventions for topographic maps" href="http://en.wikipedia.org/wiki/Wikipedia:WikiProject_Maps/Conventions/Topographic_maps" target="_blank">Wikipedia conventions for topographic maps</a>. Finally, I bring together the map pictures with a jQuery image slider called <a title="Coin Slider page" href="http://workshop.rs/projects/coin-slider/" target="_blank">Coin Slider</a>.</span></p>
