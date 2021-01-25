#!/bin/sh

echo "#############################"
echo "# Command Central Inventory #"
echo "#############################"

echo -e "\n### Installed Command Central products:"
sagcc list inventory products nodeAlias=local properties=product.displayName,product.version.string
echo -e "\n### Installed Command Central fixes:"
sagcc list inventory fixes nodeAlias=local properties=fix.displayName,fix.version
echo -e "\n### Registered NODES:"
sagcc list landscape nodes properties="*"

echo -e "\n### Registered PRODUCT repos:"
if sagcc list repository products properties="*" -e $REPO_PRODUCT_NAME -w 0; then
    echo -e "\n### Available products:"
    sagcc list repository products content $REPO_PRODUCT_NAME
fi

echo -e "\n### Registered FIX repos:"
if sagcc list repository fixes properties="*" -e $REPO_FIX_NAME -w 0; then
    echo -e "\n### Available fixes:"
    # sagcc list repository fixes content $REPO_FIX_NAME
fi

echo -e "\n### Registered ASSET repos:"
sagcc list repository assets properties="*"

echo -e "\n### Registered lisense KEYS:"
sagcc list license-tools keys properties="*"

echo -e "\n### Registered TEMPLATES:"
sagcc list templates composite

echo "#############################"
