if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "--target=/Users/$(whoami) --verbose" >.stowrc
else
  echo "--target=/home/$(whoami) --verbose" >.stowrc
fi
