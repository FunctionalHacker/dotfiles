var child_process = require("child_process");

function getStdout(cmd) {
  var stdout = child_process.execSync(cmd);
  return stdout.toString().trim();
}

exports.host = "imap.migadu.com";
exports.port = 993;
exports.tls = true;
exports.tlsOptions = {
  rejectUnauthorized: true,
};
exports.username = "admin@korhonen.cc";
exports.password = "{{@@ env['PASS_EMAIL_ADMIN'] @@}}";
exports.onNewMail = "mbsync admin@korhonen.cc";
exports.onNewMailPost =
  "~/git/dotfiles/scripts/mail/notify-new-mail.sh admin@korhonen.cc";
exports.boxes = ["INBOX"];
