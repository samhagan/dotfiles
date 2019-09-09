#compdef nashctl

_arguments \
  '1: :->level1' \
  '2: :->level2' \
  '3: :_files'
case $state in
  level1)
    case $words[1] in
      nashctl)
        _arguments '1: :(auth completion config help release version)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  level2)
    case $words[2] in
      auth)
        _arguments '2: :(activate-service-account login revoke)'
      ;;
      config)
        _arguments '2: :(current-context current-public-key delete-context disable-iap enable-iap get-all get-contexts get-email init set-context set-email update-public-key use-context)'
      ;;
      release)
        _arguments '2: :(add deploy describe list sign)'
      ;;
      *)
        _arguments '*: :_files'
      ;;
    esac
  ;;
  *)
    _arguments '*: :_files'
  ;;
esac
