rm -Rf cmtools
mkdir cmtools
pushd cmtools

git clone git://github.com/standardml/cmlib.git
mv cmlib lib
pushd lib
git checkout v1.1.2
rm -Rf .git
popd

git clone git://github.com/standardml/cmlex.git
mv cmlex lex
pushd lex
git checkout v1.1.0
sed 's/$(SMACKAGE)\/cmlib\/v1/../g' sources-generic.mlb > tempfile
mv tempfile sources-generic.mlb
sed 's/$SMACKAGE\/cmlib\/v1/../g' sources-generic.cm > tempfile
mv tempfile sources-generic.cm
rm -Rf .git
popd

git clone git://github.com/standardml/cmyacc.git
mv cmyacc yacc
pushd yacc
git checkout v1.1.0
sed 's/$(SMACKAGE)\/cmlib\/v1/../g' sources-generic.mlb > tempfile
mv tempfile sources-generic.mlb
sed 's/$SMACKAGE\/cmlib\/v1/../g' sources-generic.cm > tempfile
mv tempfile sources-generic.cm
rm -Rf .git
popd

popd
tar czf cmtools.tgz cmtools


