mkdir subeval_selected
cat subeval_audiolist.txt | while read line; do mkdir -p ./subeval_selected/$(dirname $line) && cp $line ./subeval_selected/$(dirname $line); done
tree subeval_selected
tar -czvf subeval_selected.tar.gz subeval_selected