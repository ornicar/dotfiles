#!/bin/sh

while true; do
  echo "Checking veg-1-orange-180-tablets..."
  curl 'https://www.vegansociety.com/uc_out_of_stock/query' -X POST --silent --data-raw 'form_ids%5B%5D=uc-product-add-to-cart-form-108042&node_ids%5B%5D=108042' | rg -F '"0"' >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo "!!!! https://www.vegansociety.com/shop/veg-1-supplements/veg-1-orange-180-tablets"
    mpv https://github.com/zulip/zulip/raw/refs/heads/main/static/audio/notification_sounds/ascend.ogg
  fi
  sleep 60
  echo "Checking veg-1-blackcurrant-180-tablets..."
  curl 'https://www.vegansociety.com/uc_out_of_stock/query' -X POST --silent --data-raw 'form_ids%5B%5D=uc-product-add-to-cart-form-108041&node_ids%5B%5D=108041' | rg -F '"0"' >/dev/null 2>&1
  if [[ $? -ne 0 ]]; then
    echo "!!!! https://www.vegansociety.com/shop/veg-1-supplements/veg-1--180-tablets"
    mpv https://github.com/zulip/zulip/raw/refs/heads/main/static/audio/notification_sounds/ascend.ogg
  fi
  sleep 60
done
