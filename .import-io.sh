#
# Import.io
#

io-extractor-url-query() {
    typeset -r extractor_id=$1
    typeset -r url=$2
    typeset -r query_url=$(echo $url | python -c "import urllib; import sys; print(urllib.quote_plus(sys.stdin.readlines()[0]))")

    if [ $# -ne 2 ]
    then
        echo "usage: io-extractor-url-query extractor_id url"
        return 1
    fi
    curl -s -X GET "https://extraction.import.io/query/extractor/${extractor_id}?_apikey=$IMPORT_IO_API_KEY&url=$query_url" | jq .
}

io-extractor-start() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
       echo "usage: io-extractor-url-list extractor_id"
       return 1
    fi
    curl -s -X POST "https://run.import.io/${extractor_id}/start?_apikey=$IMPORT_IO_API_KEY" | jq .
}

io-extractor-url-list-get() {
    if [ $# -ne 1 ]
    then
       echo "usage: io-extractor-url-list extractor_id"
       return 1
    fi
    typeset -r extractor_id=$1
    typeset -r url_list_id=$(io-extractor-get $extractor_id | jq ".urlList" | tr -d '"')

    curl -s -X GET -H 'Accept-Encoding: gzip' --compressed "https://store.import.io/store/extractor/${extractor_id}/_attachment/urlList/${url_list_id}?_apikey=$IMPORT_IO_API_KEY"
    return 0
}

io-extractor-url-list-put() {
    typeset -r extractor_id=$1
    typeset -r url_list_file=$2
    if [ $# -ne 2 ]
    then
        echo "usage: io-extractor-url-list-put extractor_id url_list_file"
	return 1
    fi

    curl -X PUT -s -H 'Content-type: text/plain' "https://store.import.io/store/extractor/${extractor_id}/_attachment/urlList?_apikey=$IMPORT_IO_API_KEY" -T "$url_list_file" | jq .
}

io-extractor-csv() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-csv extractor_id"
	return 1
    fi
    curl -s -L -X GET -H 'Accept-Encoding: gzip' --compressed "https://data.import.io/extractor/$extractor_id/csv/latest?_apikey=$IMPORT_IO_API_KEY"
}


io-extractor-open() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-open extractor_id"
	return 1
    fi
    open https://dash.import.io/$extractor_id
}

io-extractor-edit() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-edit extractor_id"
	return 1
    fi
    open "http://lightning.import.io/results?extractorGuid=$extractor_id"
}

io-extractor-get() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-get extractor_id"
	return 1
    fi
    curl -X GET -s "https://store.import.io/store/extractor/$extractor_id?_apikey=$IMPORT_IO_API_KEY" | jq .
}
