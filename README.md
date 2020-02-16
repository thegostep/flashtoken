# flash-mintable-tokens

Perfect credit with no credit limit.

## Warning

This is a new and untested idea. The contracts are simple but have not been audited. Be careful.

## Flash-mintable tokens vs flash loans

With traditional flash loans, the user goes to the lending pool and says "I will borrow this money from you, and you I promise to pay it back before the end of this transaction." And the lending pool says "Because of the atomicity of transactions, we believe you. We will let you borrow our money." Then the user takes the money to, say, Compound and does whatever they want with it.

With Flash-mintable tokens (FMTs), we cut out the lending pool entirely. The user goes directly to Compound and says "I created these tokens out of thin air, but I promise that by the end of this transaction they will be 1-to-1 backed and instantly redeemable for real ETH." And so Compound can say, "Because of the atomicity of transactions, we believe you. We will accept your newly minted tokens as money and know that they will hold value by the end of this transaction."

See the difference?

FMTs are analogous to a credit card. You can run up as high a bill as you want (aka, flash mint as many tokens as you want) so long as you pay it off before the end of the transaction. There is no "credit limit" on the card. You can charge more money than exists in all lending pools combined, no problem. As long as you pay it back before the end of the transaction.

With FMTs, the user doesn't need to pay any fees to any lending pool. They aren't limited in the number of tokens that exist in some lending pool. It is as if they have perfect credit and no credit limit.

### How do FMTs maintain their value?

By the end of any external transaction, all flash-mintable tokens (FMTs) are guaranteed to be 1-to-1 backed by their underlying token.

For example, at the end of every transaction, flash-mintable ETH (fmETH) is always backed 1-to-1 by ETH. The most basic way to mint a new fmETH token is to send 1 ETH to the fmETH contract. This mints one fmETH into existence and puts it in your account.

At any time, you can redeem your fmETH token for 1 ETH. Just send the fmETH token back to the contract. It will burn the fmETH token and send you 1 ETH.

Simple. No fees. Trustless. Easy. No "pre mine". Truly fair. Etc.

Similarly, flash-mintable DAI (fmDAI), flash-mintable REP (fmREP), and flash-mintable MKR (fmMKR) are each guaranteed to be backed 1-to-1 by DAI, REP, and MKR (respectively) at the beginning and end of every external transaction.

As a result, FMTs should always maintain a market value approximately equal to their underlying tokens.

If the market price of an FMT drops below the market price of its underlying token, then arbitrageurs will simply buy the FMT on the open market and redeem it for the underlying.

If the market price of an FMT rises above the market price of its underlying token, arbitrageurs will simply mint more of the FMT (by sending the underlying to the FMT contract) and sell it on the open market for a profit.


### How does flash minting work?

There is a second way that you can mint flash-mintable tokens: Flash Minting, and this is where FMTs get all their power.

Anyone can call the `flashMint` function and mint into their account any number of FMTs, provided that those FMTs are burned before the end of the transaction.

Since the same number of tokens that are flash-minted must also be burned by the end of the transaction, the 1-to-1 backing is always restored by the end of the transaction. As a result, anyone who holds an FMT can be certain that -- by the end of any transaction -- the FMTs will be 1-to-1 redeemable for the underlying.

So it is _always_ safe to accept an FMT, even during a flash mint transaction when there are potentially quadrillions more of them than there are underlying tokens backing them. You can be sure that any FMT you are holding will be redeemable for exactly one of its underlying tokens.

If the flash-minter fails to burn the same number of tokens they minted before the end of the transaction, the transaction reverts.

## Why would anybody accept FMTs?

Why would Uniswap, Compound, Synthetix, etc accept FMTs?

First lets answer a slightly different question: Why would any business accept Visa? Why would any pub extend a tab to Joe Sixpack? Why would any store extend credit to their customers?

The answer is that accepting Visa allows the companies to do more business. Customers without up-front capital can buy things on credit, and pay the business back later. Joe can buy beer at the pub before he gets his paycheck.

Allowing customers to use credit increases sales. Accepting Visa results in more business.

Accepting FMTs is akin to accepting Visa, but even better because you can be _certain_ that the customer will fully pay off their entire debt before the end of the current transaction. You never have to worry about chargebacks or delinquent debt. You can accept FMTs with the same confidence that you wold accept wrapped ETH. At the end of any transaction, they will always be redeemable for exactly one unit of the underlying.

So the idea is that Uniswap, Compound, Synthetix, etc would integrate FMTs because doing so is a trustless way to get more business. Users who don't have any up-front capital would be able to use those platforms and exploit market inefficiencies. All of this extra action results in those platforms taking fees.

Currently, users without up-front capital need to crawl to a flash-lending pool first. They lose money to fees and they are limited in the amount of money they can borrow. These limitations mean some business that _could_ happen never _does_ happen. By _not_ accepting FMTs, these platforms would be leaving money on the table.

By accepting FMTs, these platforms cut out the lending-pool middlemen and get direct, efficient access to the users who have no up-front capital.

And FMTs are just ERC20 tokens. There is no custom code that needs to be written to safely accept them. If your platform can accept wrapped ETH, then it can use the exact same code to accept fmETH.

