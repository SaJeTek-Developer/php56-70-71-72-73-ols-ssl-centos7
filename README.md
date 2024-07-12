# php56-70-71-72-73-ols-ssl-centos7
Openlitespeed with ssl ready, php 5.6.40 | 7.0.33 | 7.1.33 | 7.2.34 | 7.3.33, CentOS 7, Active repo, size ~983MB

[Docker image](https://hub.docker.com/r/sajetek/php56-70-71-72-73-ols-ssl-centos7) for old applications running php5.6 to php7.3<br/>
CentOS 7 with active repository (added from archives)<br/>
SSL enabled with selfsigned SSL certificate<br/>
<strong>Size: ~983MB</strong><br/>

EXPOSED PORTS: 80 443 7080<br/><br/>

<H3>Configurable:</H3>
#ENV#<br/>
DEFAULT_PHP: 56<br/>
DOCUMENT_ROOT: /<br/>

<H3>Configurable:</H3>
Set ENV DEFAULT_PHP to 56, 70, 71, 72, 73 to switch between lsphp versions<br/>
Set ENV DOCUMENT_ROOT to / for regular websites or /public for laravel applications etc. or as needed<br/>

<H4>How to run:</H4>
<code>
docker run -d -p 8708:7080 -p 8000:80 -p 8443:443 --name sajetek/php56-70-71-72-73-ols-ssl-centos7 -e "DOCUMENT_ROOT=/" -e "DEFAULT_PHP=56" docker.io/sajetek/php5.6-ols-ssl<br/>
docker run -d -p 8708:7080 -p 8000:80 -p 8443:443 --name sajetek/php56-70-71-72-73-ols-ssl-centos7 -e "DOCUMENT_ROOT=/" -e "DEFAULT_PHP=56" sajetek/php5.6-ols-ssl -v 
/some/host/path:/usr/local/lsws/Example/html
</code><br/>

<H5>WebAdmin Console (port 7080)</H5>
user: admin<br/>
pass: 123456<br/>

<H4>Modify the image if required via ssh for your needs</H4>
e.g. removing or adding modules, compiling another php etc.<br/>
<code>
image="docker.io/sajetek/php5.6-ols-ssl"<br/>
docker pull $image<br/>
container_id=$(docker run -d -it --name temp $image)<br/>
docker exec -it temp /bin/bash<br/>
</code>

#You are now chrooted into the image. type exit when finished<br/>
#Install more php versions or do what you need... add or remove modules etc.<br/>
#Type <strong>exit</strong> when finished<br/><br/>
<code>
docker commit $container_id $image<br/>
docker stop $container_id<br/>
docker rm $container_id
</code>


<H4>Openlitespeed v1.8.1</H4>
<ul><li>mod_rewrite</li><li>mod_mime</li><li>mod_headers</li><li>mod_expires</li><li>mod_auth_basic</li></ul>

<H4>lsphp</H4>
<ul><li>5.6.40</li><li>7.0.33</li><li>7.1.33</li><li>7.2.34</li><li>7.3.33</li></ul>
