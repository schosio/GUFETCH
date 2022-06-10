description=$(zenity --forms --title="Download of the SRA files" --text="Give SRR IDs (sep by ',')" --add-entry="SRR IDS 
(sep by ',')
[SRR12345, SRR23456, SRR34567]")

[[ $? != 0 ]] && exit 1
snames=$(echo $description | cut -d'|' -f1)

array=$(echo $snames | tr "," "\n")
arr=($array)

if [ "$?" -eq "0" ]; then
  data_download.sh $arr
fi
