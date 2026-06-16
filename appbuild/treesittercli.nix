{stdenv, fetchFromGithub, make}

x86_64-linux

stdenv.mkDerivation rec{
 pname = "an-app";
 version = "1.0.0";

 src = fetchFromGithub{
  owner = "someone"; 
  repo = pname;
  rev = "v${version}";
  sha256 = "00000000000000000000000000000000000000000000"
};

buildInputs = [make]

meta = with stdenv.lib; {
 description = "My C appllication"
 homepage = "https://github.com/github-owner/${pname}";
 license = licenses.mit;
 platforms = platforms.unix;
}

};
