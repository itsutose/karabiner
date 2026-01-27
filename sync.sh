#!/bin/bash

# Karabiner設定の同期スクリプト

KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"
DOTFILES_KARABINER="$HOME/dotfiles/karabiner-element/karabiner.json"

# dotfiles → Karabinerへ適用
apply() {
  if [ ! -f "$DOTFILES_KARABINER" ]; then
    echo "Error: $DOTFILES_KARABINER not found"
    return 1
  fi

  echo "Applying Karabiner config from dotfiles..."
  cp "$DOTFILES_KARABINER" "$KARABINER_CONFIG"
  chmod 600 "$KARABINER_CONFIG"
  echo "Done! Restart Karabiner-Elements to apply changes."
}

# Karabiner → dotfilesへ保存
save() {
  if [ ! -f "$KARABINER_CONFIG" ]; then
    echo "Error: $KARABINER_CONFIG not found"
    return 1
  fi

  echo "Saving Karabiner config to dotfiles..."
  cp "$KARABINER_CONFIG" "$DOTFILES_KARABINER"
  echo "Saved to: $DOTFILES_KARABINER"
  echo ""
  echo "To commit changes:"
  echo "  cd ~/dotfiles && git add karabiner-element/ && git commit -m 'Update Karabiner config'"
}

# 使い方を表示
usage() {
  echo "Usage: $0 {save|apply}"
  echo ""
  echo "Commands:"
  echo "  save   - Save current Karabiner config to dotfiles"
  echo "  apply  - Apply dotfiles Karabiner config to system"
}

# コマンド実行
case "$1" in
  save)
    save
    ;;
  apply)
    apply
    ;;
  *)
    usage
    exit 1
    ;;
esac
