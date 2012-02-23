function unzips()
{ # hack that unzips to a folder
    unzip -d ${1/.zip/} $1
}
