description=$(zenity --forms --title="Download of the SRA files" --text="Give SRR IDs (sep by ',')" --add-entry="SRR IDS 
(sep by ',')
[SRR12345, SRR23456, SRR34567]" --text="Select SRR List in next step " )

[[ $? != 0 ]] && exit 1
snames=$(echo $description | cut -d'|' -f1)

echo $snames | tr "," "\n" >SRR_Acc_List.txt

# select the Acc file

SRR=$(zenity --file-selection --filename  \
--title="***SRR Accession List file***"  --text="Select SRR Accession List file")
[[ $? != 0 ]] && exit 1

# check wheather SRA toolkit is installed or not

which vdb-config >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
  mkdir -p $HOME/application
  cd ~/application
  wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.11.2/sratoolkit.2.11.2-ubuntu64.tar.gz
  tar xzvf sratoolkit.2.4.1-ubuntu64.tar.gz
  export PATH="$HOME/application/sratoolkit.2.4.1-ubuntu64/bin:$PATH"
  cd -
fi

if [ "$?" -eq "0" ]; then
  bash $PWD/data_download.sh $SRR
fi
