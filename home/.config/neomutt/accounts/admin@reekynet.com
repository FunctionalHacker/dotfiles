# vim: filetype=muttrc

set my_email        = "admin@reekynet.com"
set from			= $my_email
set sendmail		= "/usr/bin/msmtp -a $my_email"
set realname        = "ReekyNET Admin"
set status_format   = "-%r-Mutt: $my_email %f [Msgs:%?M?%M/?%m%?n? New:%n?%?o? Old:%o?%?d? Del:%d?%?F? Flag:%F?%?t? Tag:%t?%?p? Post:%p?%?b? Inc:%b?%?l? %l?]---(%s/%S)-%>-(%P)---"
set mbox_type       = Maildir
set folder          = "~/.mail/$my_email"
set mbox            = "+INBOX"
set record          = "+INBOX"
set postponed       = "+Drafts"
set spoolfile       = "+INBOX"
mailboxes           = +INBOX
