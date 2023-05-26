<div id="top"></div>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->


<h2 align="center">Wordpress Installer</h2>
  <p align="center">
    Clean WordPress installation from scratch.
  </p>
</div>

<!-- TABLE OF CONTENTS -->
#### Table of Contents
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
  </ol>


<!-- ABOUT THE PROJECT -->
## 🚧 About The Project

This is a useful project that integrates all tools to get a clean and easy-to-use WordPress installation from scratch. <br />
* Autodeployment with git actions
* DNS A records autogeneration in CloudFlare
* AWS S3 storage for uploads
* Using RDS or local DB
* Import/Export database
* Bedrock compartible
* Tailwind framework 
* Sage + Acorn included
<p align="right">(<a href="#top">back to top</a>)</p>


### Built With

<p>
  <a href="https://www.docker.com/" target="_blank"> 
  <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-docker.svg" alt="docker" width="64" height="64"/></a>
  <a href="https://docs.docker.com/compose/" target="_blank"> <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-docker-compose.svg" alt="docker" width="64" height="64"/></a>
  <a href="https://wordpress.com/" target="_blank"> <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-wordpress.svg" alt="docker" width="64" height="64"/></a>
  <a href="https://wp-cli.org/" target="_blank"> <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-wp-cli.svg" alt="docker" width="64" height="64"/></a>
  <a href="https://www.mysql.com/" target="_blank"> <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-mysql.svg" alt="mysql" width="64" height="64"/></a>
  <a href="https://www.phpmyadmin.net/" target="_blank"> <img src="https://github.com/cosimoscarcella/cosimoscarcella/raw/main/images/logo-phpmyadmin.svg" alt="mysql" width="64" height="64"/></a>
  <a href="https://www.cloudflare.com/" target="_blank">
  <img src="https://user-images.githubusercontent.com/67096472/208312374-eec3b4bd-f042-4ff3-8dd6-93dc07c050dc.png" alt="cloudflare" width="64" height="64"/>
</a>
  <a href="https://aws.amazon.com/" target="_blank">
  <img src="https://user-images.githubusercontent.com/67096472/208317370-09383871-9e77-42bb-a61a-78ec183f246b.png" alt="AWS" width="64" height="64"/>
</a>


</p> 
<p align="right">(<a href="#top">back to top</a>)</p>




<!-- GETTING STARTED -->
## 🏃 Getting Started

To get your WordPress installation running follow these simple steps.

### Prerequisites

#### Local dev
* [Docker](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Ubuntu](https://ubuntu.com/) or wsl2 on windows
#### Dev server
* Nginx
* Git
* Docker
* Docker Compose

### Init New Project

1. Create new repo from this template
![image](https://user-images.githubusercontent.com/67096472/208317268-896a490c-94ea-44e6-85f4-c17429246aff.png)
2. Add DEPLOY_KEY (private ssh key), DEPLOY_USERNAME, HOST_IP, SSH_HOST to git secret (Find 'WP Docker ENV' base in our onepassword )
3. Clone your repo
4. Go into the created repo folder 
   ```cd ./%your_repo%```
5. Run command for shell scripts
   ```sh 
   find . -type f -iname "*.sh" -exec chmod +x {} \;
   ``` 
<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## 🚀 Usage

### Install
#### (Local development)
1. Modify passwords and variables inside ```.env``` file as you wish, set USE_LOCAL to ```true``` (Find 'WP Docker ENV' base in our onepassword ) 
2. Run shell command for build
   ```sh wp-run.sh ```
3. Active sage template if needed

#### (Deploy to server)
 
1. Run ```sh wp-deploy.sh``` onetime, to pull project
2. Make first commit to repo and push to main

### Uninstall

1. Run shell command
   ```sh wp-uninstall.sh -v -i```
2. Use ```-h | --help``` option for further information

### Execute wp-cli command
1. Run shell command
   ```sh
   sh wp-cli.sh "<command>"
   ```
   to execute your custom wp-cli commands. For example ```sh wp-cli.sh "wp db export -" > dump.sql``` to export wordpress database

### Switch to remote db

1. Change ```USE_EXTERNAL_DATABASE=false``` to ```true``` in .env
2. Run docker builds ```sh wp-build.sh``` and ``` sh wp-init.sh ```
3. Run deploy to remote ```sh wp-deploy.sh```

### Commits

Commit and push to main branch to run autodeploy on server. <br />
Every commit on main branch generate new tag with commit title

<p align="right">(<a href="#top">back to top</a>)</p>

### Import/export DB

Use ```sh wp-export.sh``` to export current local or RDS DB, it`s stored in ```dump``` folder.<br />
To import DB on remote server manualy, use ```sh wp-import.sh``` command.<br />
To import DB on remote with commit, just run DB export and push to branch with commit ```Update DB```
<p align="right">(<a href="#top">back to top</a>)</p>


### Acorn

Use ```sh wp-acorn.sh "help"``` to run acorn commands<br />

<code>USAGE: sh wp-acorn.sh "command [options] [arguments]"</code>

<code>clear-compiled </code>  Remove the compiled class file<br />
<code>completion </code>      Dump the shell completion script<br />
<code>env</code>              Display the current framework environment<br />
<code>help</code>             Display <span class="hljs-built_in">help</span> <span class="hljs-keyword">for</span> a <span class="hljs-built_in">command</span><br />
<code>list</code>             List commands<br />
<code>optimize</code>         Cache the framework bootstrap files<br />
<code>acorn:init</code>       Initializes required paths <span class="hljs-keyword">in</span> the base directory.<br />
<code>config:cache</code>     Create a cache file <span class="hljs-keyword">for</span> faster configuration loading<br />
<code>config:clear</code>     Remove the configuration cache file<br />
<code>make:command </code>    Create a new Artisan <span class="hljs-built_in">command</span><br />
<code>make:component</code>   Create a new view component class<br />
<code>make:composer</code>    Create a new view composer class<br />
<code>make:provider</code>    Create a new service provider class<br />
<code>optimize:clear</code>   Remove the cached bootstrap files<br />
<code>package:discover</code> Rebuild the cached package manifest<br />
<code>vendor:publish</code>   Publish any publishable assets from vendor packages<br />
<code>view:cache </code>      Compile all of the application's Blade templates<br />
<code>view:clear </code>      Clear all compiled view files
<br />

To fix acorn cache problem on remote server, run ```chmod -R ubuntu:www-data wp_data/wp-content/cache```

<p align="right">(<a href="#top">back to top</a>)</p>

### Sage

Run ```sh wp-sage.sh``` to build and star working with sage template<br />
Make sure if acorn plugin and sage tamplate is active. <br />
More docs in https://roots.io/sage/docs/