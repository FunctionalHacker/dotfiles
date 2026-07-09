{%@@ if profile == "Moria" @@%}
# Auto-start CRT menu only on TTY (kmscon)
if [[ "$TERM" == 'kmscon' ]]; then
    exec $HOME/.scripts/crt-menu
fi
{%@@ endif @@%}
