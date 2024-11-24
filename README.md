# hook-tokens
Solidity ERC-20 implementation that uses callback hooks instead of approvals to interact with apps.

## Goals
The UX of having to make approval transactions before interacting with an app increases friction and is a barrier to adoption. Hook tokens aim to solve this problem by allowing users to interact with apps without the need for approval.

## How it works

1. App developer implements the logic contract using the "activate" function.
2. App developer calls `registerApp` to store which logic contract should be called as a hook when tokens are sent to the app.
3. User sends tokens to the app.
4. When tokens are sent to the app, the logic contract's activate function is called.

Simple. No tokens are pulled from the user's wallet, and the user only needed to send 1 transaction to interact with the app.

## Notes
This is similar to ERC20Receiver implented in eip-4524, but doesnt require that ERC20Receiver be implenented in order to send tokens.
Also, logic can be called on contract A, when tokens are sent to contract B who has registered it such, allowing for more flexibility.
