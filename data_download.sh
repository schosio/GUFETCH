#!/bin/bash
#####################################################################
#  SRR_Acc_List.txt file contains SRR identfiers of the respecive SRA files in following format: separated by newline
# SRR5370445
# SRR5370445
#####################################################################
#  To download the accession list, use the following steps.

# 1. Go to the bioproject page in GEO database from NCBI
# 2. Move to SRA run selector  at the bottom of the page
# 3. Click on the Accession List
# 4. Voila, the Accession list is downloaded: SRR_Acc_List.txt

# srr_acc is location of SRR_Acc_List.txt file
srr_acc=SRR_Acc_List.txt

# for checking space
temp=0
while read -r line
  do
     space=$(vdb-dump --info $line | grep size | awk -F ":" '{print $2}'| tr -d ',')
     temp=$(( $temp + $space ))
  done < ${srr_acc}
# spcae in GB
new=$((temp*10))
new=$(echo $new | awk '{print $1/1024/1024/1024}')

echo
echo
echo
echo "###############################################################"
echo "


      	********************************************************
        *                                                      *
        *                                                      *
        * Space required for all the samples is $new GB
        *                                                      *
        *                                                      *
        ********************************************************
        "
echo
echo
echo "###############################################################"
echo
echo

while read -r line; do
                # Reading each line
                        echo $line
                        ls ${line}*
                        if [ $? -ne 0 ]
                            then
                              fasterq-dump -p $line -O .
                        fi
                        done < ${srr_acc}
