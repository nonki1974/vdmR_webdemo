# Sample Web application using vdmR package

2017/10/03

This document illustrates the procedure for running the sample Web application using [vdmR](https://cran.r-project.org/web/packages/vdmR/index.html) package.

## Environment

- Ubuntu Server 16.04 LTS (minimum install)

## Installation

### 1. Installing apache2

    $ sudo apt-get install apache2 apache2-dev libapreq2-dev
    $ sudo ln -s /etc/apache2/mods-available/userdir.load /etc/apache2/mods-enabled/
    $ sudo ln -s /etc/apache2/mods-available/userdir.conf /etc/apache2/mods-enabled/

### 2. Installing latest version of R

    $ sudo sh -c "echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' \
    > /etc/apt/sources.list.d/cran.list"
    $ gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
    $ gpg -a --export E084DAB9 | sudo apt-key add -
    $ sudo apt-get update
    $ sudo apt-get install r-base r-base-dev


### 3. Installing rApache

    $ sudo apt-get install devscripts git
    $ git clone https://github.com/jeffreyhorner/rapache
    $ cd rapache
    $ debuild -us -uc
    $ cd ..
    $ sudo dpkg -i libapache2-mod-r-base*.deb

### 4. Installing vdmR and brew package

    $ sudo apt-get install libgdal-dev libproj-dev libgeos-dev
    $ sudo R
    > install.packages(c("vdmR", "brew"))

### 5. Configuration for rApache

    $ sudo vi /etc/apache2/mods-available/mod_R.conf

Edit `mod_R.conf` as follows.

```
REvalOnStartup "library(vdmR)"
REvalOnStartup "library(MASS)"

REvalOnStartup "my.source <- function(file=NULL,envir=NULL) sys.source(file,envir=new.env(parent=globalenv()))"

<Files *.R>
        SetHandler r-script
        RHandler my.source
</Files>

<Files *.brew>
        SetHandler r-script
        RHandler brew::brew
</Files>
```

  $ sudo ln -s /etc/apache2/mods-available/mod_R.conf /etc/apache2/mods-enabled/


### 6. Restarting apache2

    $ sudo service apache2 restart

### 7. Downloading and Setting files

    $ mkdir public_html
    $ cd public_html
    $ git clone https://github.com/nonki1974/vdmR_webdemo
    $ cd vdmR_webdemo
    $ mkdir temp
    $ chmod 777 temp

### 8. Access to demo page

Access to http://IP_ADDRESS/~USERNAME/vdmR_webdemo/
