DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOME_DIR="$( cd ~ && pwd )"
FILES=$(ls $DIR -A)

for FILE in $FILES; do
  if [ -d $DIR/$FILE ]; then
    if [ ! -d $HOME_DIR/$FILE ]; then
      mkdir -p $HOME_DIR/$FILE
    fi
  cp -r $DIR/$FILE/* $HOME_DIR/$FILE
  else
    cp $DIR/$FILE $HOME_DIR/$FILE
  fi
done
