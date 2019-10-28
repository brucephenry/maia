# README for Maia

# About
Maia is a utility to create fixVersions (aka Releases) in Atlassian Jira using OAuth1.0 authenticated https requests.

## Design
The basic design is that it reads from exteralized key files for OAuth tokens (the OAuth1.0 dance needs to be done
seperately via another utility like OAF.

# To Do
* Add a link to the readme.md for OAF
* Move the key files filenames & path to a configuration file (e.g. maia.cfg or maia.yaml).
* Write the code to read from a releases file and create those iteratively in Jira
* Write results to a log file (e.g. maia_datetime.log) 

# Known Issues
* 

# Examples
*

# Details
* Ruby version

ruby 2.6.4p104 or later

* System dependencies


* Configuration

Needs access to the folder in which your relevant key files for OAuth are located.
These key files can be generated using the OAuth Facilitator v2 (OAF2) found in the same directory as this README.

* How to run the test suite

LOL

* Deployment instructions

Copy it, run it.

# Maia? WTF?

Maia, daughter of the titan Atlas. Jira... Atlassian... get it?
Sigh... never mind.