description=$(zenity --forms --title="Download of the SRA files" --text="Give SRR IDs (sep by ',')" --add-entry="SRR IDS 
(sep by ',')
[SRR12345, SRR23456, SRR34567]")

[[ $? != 0 ]] && exit 1
snames=$(echo $description | cut -d'|' -f1)

echo $snames | tr "," "\n" >srr_acc.txt

if [ "$?" -eq "0" ]; then
  bash $PWD/data_download.sh 
fi
