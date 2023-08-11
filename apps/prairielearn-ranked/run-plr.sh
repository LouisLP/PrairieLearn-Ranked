docker run -it --rm -p 3000:3000 -w /PrairieLearn -v {PWD}:/PrairieLearn trustyturkey/plr /bin/bash;
make deps;
make start;