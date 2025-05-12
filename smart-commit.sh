#!/bin/bash

# Menu de seleção de idioma com opção padrão (Enter = pt-br)
# PS3="Selecione o idioma do prompt (1 = pt-br, 2 = en-us, Enter = pt-br): "
# options=("pt-br" "en-us")

while true; do
  echo -n "Selecione o idioma do prompt [1 = pt-br, 2 = en-us, Enter = pt-br]: "
  read input

  case "$input" in
    1|"") lang="pt-br"; break ;;
    2)    lang="en-us"; break ;;
    *)    echo "❌ Opção inválida. Digite 1, 2 ou apenas Enter." ;;
  esac
done

# Prompt dinâmico
prompt="gera um comando de commit em ${lang} com conventional commits com uma mensagem que faça sentido para as alterações a seguir: $(git diff --cached)"

ghcs() {
        FUNCNAME="$funcstack[1]"
        TARGET="shell"
        local GH_DEBUG="$GH_DEBUG"
        local GH_HOST="$GH_HOST"

        local OPT OPTARG OPTIND
        while getopts "dht:-:" OPT; do
                if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
                        OPT="${OPTARG%%=*}"       # extract long option name
                        OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
                        OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
                fi

                case "$OPT" in
                        debug | d)
                                GH_DEBUG=api
                                ;;

                        help | h)
                                echo "$__USAGE"
                                return 0
                                ;;

                        hostname)
                                GH_HOST="$OPTARG"
                                ;;

                        target | t)
                                TARGET="$OPTARG"
                                ;;
                esac
        done

        # shift so that $@, $1, etc. refer to the non-option arguments
        shift "$((OPTIND-1))"

        TMPFILE="$(mktemp -t gh-copilotXXXXXX)"
        trap 'rm -f "$TMPFILE"' EXIT
        if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
                if [ -s "$TMPFILE" ]; then
                        FIXED_CMD="$(cat $TMPFILE)"
                        print -s "$FIXED_CMD"
                        echo
                        eval "$FIXED_CMD"
                fi
        else
                return 1
        fi
}

ghcs "$prompt"
