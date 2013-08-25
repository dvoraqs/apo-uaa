Website for the Alpha Zeta Eta Chapter of Alpha Phi Omega
=========================================================

Technology Overview
-------------------

- Git: The program we are using to download the website files and push the changes back to the server
- Ruby: Programming language we are using on the server
- Rails: Ruby web framework we are using to serve the website on the server
- Openshift: 'Platform as a Service' Cloud hosting service that hosts our website
- Bootstrap: Web UI framework used to make our website pretty

First Time Setup
----------------

- Install Git
	- Download: http://git-scm.com/download
	- When installing in Windows, I recommend choosing the oftion to 'Run Git from the Windows Command Prompt' and to 'Checkout Windows-style, commit Unix-style line endings'
- Install Ruby (Version 1.9)
	- Download: http://rubyinstaller.org/downloads
	- I would recommend checking the option to add the Ruby stuff to your system PATH during installation if you're on Windows
- Install Ruby Development Kit
	- Instructions: https://github.com/oneclick/rubyinstaller/wiki/Development-Kit
	- Download: http://rubyinstaller.org/downloads
- Install Rails (Ruby on Rails)
	- Command: `gem install rails`
- Setup your computer for Openshift:
	- Instructions: https://www.openshift.com/developers/rhc-client-tools-install
	- Command: `gem install rhc`
	- Command: `rhc setup`
	- Refer to the Credentials file (available outside of this repository to officers in the chapter) for the Openshift username and password
	- You should create and upload the SSH Key for your computer during the process
- Clone the site repository:
	- The address for git repository can be obtained in the Credentials File or by signing into the Openshift website, then going to the page for the Site application
	- Command: `git clone [git repository address]`
- Install the Ruby Gems used on the site
	- Command: `bundle install`

Now you're ready to do work on the site!

Test the site on a local server by running `rails server` and going to 'http://localhost:3000/' in your browser.
Apply changes to the server by using Git to make a commit of local changes and then push the commit to the server.

Troubleshooting Tips
--------------------

If the server does not start again after pushing changes, restart the server, which is possible on the openshift website, the RHC command-line tool, or SSH-ing into the server.

In Ubuntu, installing nodejs (command: `sudo apt-get install nodejs`) solved a problem with javascript engines or something when trying to start the local server
