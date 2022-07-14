{ lib, stdenv, fetchurl, pkg-config, perl, openssl, db, cyrus_sasl
, cyrus_sasl_xoauth2, zlib, Security }:

stdenv.mkDerivation rec {
  pname = "isync-isync";
  version = "c97d99c85c32f285e55e62a246b3715fa26241f2";

  src = fetchurl {
    url = "https://github.com/xukai92/isync/archive/${version}.tar.gz";
    sha256 = "1zq0wwvmqsl9y71546dr0aygzn9gjjfiw19hlcq87s929y4p6ckw";
  };

  nativeBuildInputs = [ pkg-config perl ];
  buildInputs = [ openssl db cyrus_sasl cyrus_sasl_xoauth2 zlib ]
    ++ lib.optionals stdenv.isDarwin [ Security ];

  meta = with lib; {
    homepage = "http://isync.sourceforge.net/";
    # https://sourceforge.net/projects/isync/
    changelog =
      "https://sourceforge.net/p/isync/isync/ci/v${version}/tree/NEWS";
    description = "Free IMAP and MailDir mailbox synchronizer";
    longDescription = ''
      mbsync (formerly isync) is a command line application which synchronizes
      mailboxes. Currently Maildir and IMAP4 mailboxes are supported. New
      messages, message deletions and flag changes can be propagated both ways.
    '';
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ primeos lheckemann ];
    mainProgram = "mbsync";
  };
}
