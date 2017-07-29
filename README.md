# atom-hugo package

[![apm](https://img.shields.io/apm/v/atom-hugo.svg)](https://atom.io/packages/atom-hugo)

Hugo package for Atom.

## Installation

Install via Atom or with `apm`:

```
$ apm install atom-hugo
```

## Features

The package allows you to run the following `hugo` commands from Atom:

* Create new content for your site (&#x2303;&#x2318;N)
* Create a new site skeleton (&#x2303;&#x2318;S)
* Build your site once ready for deployment (&#x2303;&#x2318;B)
* Build and serve your site on the Hugo webserver (&#x2303;&#x2318;H, stop with &#x2303;&#x2318;C)

## Configuration

You can configure the commands in the package settings to suit your needs:

- Change the format (`yaml`, `json` or `toml`) of the site config
- Include content marked as draft
- Include expired content
- Include content with a publish date in the future
- Watch filesystem for changes and recreate as needed (equivalent to `--watch`)
