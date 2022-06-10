description=$(zenity --forms --title="Download of the SRA files" --text="Give SRR IDs (sep by ',')" --add-entry="SRR IDS 
(sep by ',')
[SRR12345, SRR23456, SRR34567]")

[[ $? != 0 ]] && exit 1
snames=$(echo $description | cut -d'|' -f1)

echo $snames | tr "," "\n" >srr_acc.txt

# check wheather SRA toolkit is installed or not

which vdb-config >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
mkdir -p /opt/application
cd /opt/application
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.1/sratoolkit.2.4.1-ubuntu64.tar.gz
tar xzvf sratoolkit.2.4.1-ubuntu64.tar.gz
export PATH=$PATH:/opt/application/sratoolkit.2.4.1-ubuntu64/bin
fi

if [ "$?" -eq "0" ]; then
  bash $PWD/data_download.sh 
fi
