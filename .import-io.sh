#
# Import.io
#

# Using these shell functions required the following command line tools be present in your
# environment and your PATH:
#
#  bash
#  curl
#  jq => https://stedolan.github.io/jq/
#  open Mac OS X helper command line tool that can launch the active browser (see man -s 1 open)
#
# Configuration
# 
# 1. Add an environment variable to .bash_profile IMPORT_IO_API_KEY that contains
#    your import-io API Key
#
# 2. Add this file (.import-io.sh) contains shell functions to your file system in known location
#
# Example configuration in my current ~/.bash_profile which consists of a file ~/.import-io that
# contains:
#
#    export IMPORT_IO_API_KEY=<import.io api key>
#
# The following are then used to include the environment variable definition and shell functions:
#
#     IMPORT_IO_RC=$HOME/.import-io
#     [ -r "$IMPORT_IO_RC" ] && source "$IMPORT_IO_RC"
# 
#     IMPORT_IO_FUNC=$HOME/.import-io.sh
#     [ -r "$IMPORT_IO_FUNC" ] && source "$IMPORT_IO_FUNC"


io-extractor-crawl-run() {
    typeset -r extractor_id=$1
    typeset -r crawl_run_id=$2
    typeset -r page=1
    typeset -r per_page=100

    if [ $# -lt 1 ]
    then
        echo "usage: io-extractor-crawl-run extractor_id craw_run_id"
        return 1
    fi

    if [ $# -eq 2 ]
    then 
        curl -s X GET "https://store.import.io/store/crawlrun/_search?_sort=_meta.creationTimestamp&_page=${page}&_perPage=${per_page}&extractorId=${extractor_id}&_apikey=$IMPORT_IO_API_KEY" | jq ".hits.hits | .[] | select(._id==\"${crawl_run_id}\")"
    else
       curl -s X GET "https://store.import.io/store/crawlrun/_search?_sort=_meta.creationTimestamp&_page=${page}&_perPage=${per_page}&extractorId=${extractor_id}&_apikey=$IMPORT_IO_API_KEY" | jq .
    fi

}

io-extractor-crawl-run-history() {
    typeset -r extractor_id=$1

    if [ $# -lt 1 ]
    then
        echo "usage: io-extractor-crawl-run-history extractor_id craw_run_id page"
        return 1
    fi

    io-extractor-crawl-run $extractor_id | jq '.hits.hits | .[] | .fields | {state: .state, started: (.startedAt/1000|todateiso8601), stopped: (.stoppedAt/1000|todateiso8601), guid: .csv, urls: .totalUrlCount, successes: .successUrlCount, failed: .failedUrlCount, rows: .rowCount}'

}

io-extractor-crawl-run-csv() {
    typeset -r extractor_id=$1
    typeset -r crawl_run_id=$2

    if [ $# -ne 2 ]
    then
        echo "usage: io-extractor-crawl-run-csv extractor_id craw_run_id"
        return 1
    fi

    csv_id=$(io-extractor-crawl-run $extractor_id  $crawl_run_id | jq '.fields.csv' | tr -d '"')

    curl -s -X GET -H 'Accept-Encoding: gzip' --compressed "https://store.import.io/store/crawlRun/$crawl_run_id/_attachment/csv/$csv_id?_apikey=$IMPORT_IO_API_KEY"
}

io-extractor-crawl-run-state() {
    typeset -r extractor_id=$1
    typeset -r crawl_run_id=$2

    if [ $# -ne 2 ]
    then
        echo "usage: io-extractor-crawl-run-state extractor_id craw_run_id"
        return 1
    fi

    io-extractor-crawl-run ${extractor_id} ${crawl_run_id} | jq .fields.state | tr -d '"'
}

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
       echo "usage: io-extractor-start extractor_id"
       return 1
    fi
    curl -s -X POST "https://run.import.io/${extractor_id}/start?_apikey=$IMPORT_IO_API_KEY" | jq .
}

io-extractor-url-list-get() {
    if [ $# -ne 1 ]
    then
       echo "usage: io-extractor-url-list-get extractor_id"
       return 1
    fi
    typeset -r extractor_id=$1
    typeset -r url_list_id=$(io-extractor-get $extractor_id | jq ".urlList" | tr -d '"')

    curl -s -X GET -H 'Accept-Encoding: gzip' --compressed "https://store.import.io/store/extractor/${extractor_id}/_attachment/urlList/${url_list_id}?_apikey=$IMPORT_IO_API_KEY"
    return 0
}

io-extractor-training-get() {
    if [ $# -ne 1 ]
    then
       echo "usage: io-extractor-training-get extractor_id"
       return 1
    fi
    typeset -r extractor_id=$1
    typeset -r training_id=$(io-extractor-get $extractor_id | jq ".training" | tr -d '"')

    curl -s -X GET -H 'Accept-Encoding: gzip' --compressed "https://store.import.io/store/extractor/${extractor_id}/_attachment/training/${training_id}?_apikey=$IMPORT_IO_API_KEY" | jq .
    return 0
}

io-extractor-config-get() {
    if [ $# -ne 1 ]
    then
       echo "usage: io-extractor-config-get extractor_id"
       return 1
    fi
    typeset -r extractor_id=$1
    typeset -r config_id=$(io-extractor-get $extractor_id | jq ".latestConfigId" | tr -d '"')

    curl -s -X GET -H 'Accept-Encoding: gzip' --compressed "https://store.import.io/store/extractor/${extractor_id}/_attachment/configuration/${config_id}?_apikey=$IMPORT_IO_API_KEY" | jq .
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

io-extractor-json() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-json extractor_id"
	return 1
    fi
    curl -s -L -X GET -H 'Accept-Encoding: gzip' --compressed "https://data.import.io/extractor/$extractor_id/json/latest?_apikey=$IMPORT_IO_API_KEY"
}


io-extractor-edit() {
    typeset -r extractor_id=$1
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-open extractor_id"
	return 1
    fi
    open https://dash.import.io/$extractor_id
}

io-extractor-new() {
    typeset -r url=$1
    typeset -r query_url=$(echo $url | python -c "import urllib; import sys; print(urllib.quote_plus(sys.stdin.readlines()[0]))")
    if [ $# -ne 1 ]
    then
        echo "usage: io-extractor-edit url"
	return 1
    fi
    open "http://lightning.import.io/results?url=$query_url"
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

io-extractor-list() {
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
do
    curl -X GET -s "https://store.import.io/store/extractor/_search?_sort=_meta.creationTimestamp&_mine=true&q=_missing_%3Aarchived%20OR%20archived%3Afalse&_page=$i&_apikey=$IMPORT_IO_API_KEY" | jq .
done
}


