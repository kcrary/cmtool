rm -Rf cmtools
mkdir cmtools
pushd cmtools

git clone git://github.com/standardml/cmlib.git
mv cmlib lib
pushd lib
# Comment out the next line to get the most recent version of cmlib
# Edit it to get a different specific version of cmlib
rm -Rf .git
popd

git clone git://github.com/standardml/cmlex.git
mv cmlex lex
pushd lex
# Comment out the next line to get the most recent version of cmlex
# Edit it to get a different specific version of cmlex
git checkout v1.1.0
sed 's/$(SMACKAGE)\/cmlib\/v1/..\/lib/g' sources-generic.mlb > tempfile
mv tempfile sources-generic.mlb
sed 's/$SMACKAGE\/cmlib\/v1/..\/lib/g' sources-generic.cm > tempfile
mv tempfile sources-generic.cm
rm -Rf .git
popd

git clone git://github.com/standardml/cmyacc.git
mv cmyacc yacc
pushd yacc
# Comment out the next line to get the most recent version of cmyacc
# Edit it to get a different specific version of cmyacc
git checkout v1.1.0
sed 's/$(SMACKAGE)\/cmlib\/v1/..\/lib/g' sources-generic.mlb > tempfile
mv tempfile sources-generic.mlb
sed 's/$SMACKAGE\/cmlib\/v1/..\/lib/g' sources-generic.cm > tempfile
mv tempfile sources-generic.cm
rm -Rf .git
popd

popd
tar czf cmtools.tgz cmtools
rm -Rf cmtools


