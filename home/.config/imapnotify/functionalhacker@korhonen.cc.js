var child_process = require('child_process');

function getStdout(cmd) {
  var stdout = child_process.execSync(cmd);
  return stdout.toString().trim();
}

exports.host = 'imap.migadu.com';
exports.port = 993;
exports.tls = true;
exports.tlsOptions = {
  rejectUnauthorized: true,
};
exports.username = 'functionalhacker@korhonen.cc';
exports.password = "{{@@ env['PASS_EMAIL_HACKER'] @@}}";
exports.onNewMail = 'mbsync functionalhacker@korhonen.cc';
exports.onNewMailPost =
  '~/git/dotfiles/scripts/mail/notify-new-mail.sh functionalhacker@korhonen.cc';
exports.boxes = ['INBOX'];
