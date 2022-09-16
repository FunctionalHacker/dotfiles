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
exports.username = 'marko@korhonen.cc';
exports.password = "{{@@ env['PASS_EMAIL_MARKO'] @@}}";
exports.onNewMail = 'mbsync marko@korhonen.cc';
exports.onNewMailPost =
  '~/git/dotfiles/scripts/mail/notify-new-mail.sh marko@korhonen.cc';
exports.boxes = ['INBOX'];
