curl -O http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum2.zip | #technically curl -s, and the zip is already downloaded, just need to pipe
gunzip | cut -d "," -f3 | sed 's/"//g' | #now you can grep for companies
grep -i twitter
#AS35995 Twitter inc.
#now whois thee ASN and map to address space
#use whois.radb.net for ASN mapping, ex: '-i origin as####' in the search
