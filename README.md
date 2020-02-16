# flash-mintable-tokens

"Anyone can be arbitrarily rich, for an instant."


## Warning

This is a new and untested idea. The contracts are simple but have not been audited. Be careful before 

These contracts are simple, but have not been audited. Please don't use them with any amount of money that you don't feel like losing. More importantly, please don't plug these tokens into your platform (e.g. Uniswap, Compound, Maker CDP, etc) unless you've thought much longer and harder about the ramifications than I have.

This is just a fun experiment. Please don't lose any of your hard-earned money.

## What are flash-mintable tokens?

Flash-mintable tokens (FMTs) are a new and more powerful form of flash lending. With traditional flash loans, an arbitrageur who needs $250M in DAI to exploit an inefficiency needs to go find some lending platform that has $250M in DAI and is willing to flash lend it.

With FMTs, the arbitrageur no longer needs to crawl to some lending platform for money. Instead, they can literally mint the money into existence -- on their own, with no counterparty needed. They can use their newly minted money to exploit market inefficiencies, and then -- in the same transaction in which they created the money -- they destroy it.

Anyone who accepts an FMT (such as a DEX or lending platform) can be 100% certain that - by the end of the transaction in which they received it -- the FMT will maintain full market value.

Literally trillions of dollars in value can be minted into existence, used for arbitrage, and then destroyed in the same transaction. And everyone holding the FMT can be certain that it maintains its market value.

### How do FMTs maintain their value?

At the beginning and end of any external transaction, all flash-mintable tokens (FMTs) are guaranteed to be 1-to-1 backed by some other underlying token.

For example, flash-mintable ETH (fmETH) is backed 1-to-1 by ETH. The most basic way to mint a new fmETH token is to send 1 ETH to the fmETH contract. This mints one fmETH into existence and puts it in your account.

At any time, you can redeem your fmETH token for 1 ETH. Just send the fmETH token back to the contract. It will burn the fmETH token and send you 1 ETH.

Simple. No fees. Trustless. Easy. No "pre mine". Truly fair. Etc.

Similarly, flash-mintable DAI (fmDAI), flash-mintable REP (fmREP), and flash-mintable MKR (fmMKR) are each guaranteed to be backed 1-to-1 by DAI, REP, and MKR (respectively) at the beginning and end of every external transaction.

As a result, FMTs should always maintain a market value approximately equal to their underlying tokens. If the price of an FMT dropped below the market price of its underlying token, then arbitrageurs would simply buy the FMT and redeem it for the underlying.

### How does flash minting work?

There is a second way that you can mint flash-mintable tokens: Flash Minting.

Anyone can call the `flashMint` function and mint into their account any number of FTMs, provided that those FMTs are burned before the end of the transaction.

Since the number of tokens flash-minted must also be burned by the end of the transaction, anyone who holds an FMT can always be certain that -- at the beginning and end of any external transaction -- the FMTs will be redeemable for the underlying.

So it it _always_ safe to accept an FMT, even during a flash mint transaction when there are potentially quadrillions more of them than there are underlying tokens backing them. You can be sure that -- if you are still holding an FMT by the end of the current transaction -- it will be redeemable for exactly one of its underlying tokens.

If the flash-minter fails to burn the same number of tokens they minted before the end of the transaction, the transaction reverts.

## Unlimited liquidity. From nothing.

One incredible property of FMTs is that even if there are no FMTs in existence at the beginning of a transaction, you can still mint an arbitrary number of them into existence, and during your flash loan, people can still safely accept them at face value.

For example: If no fmETH currently exist (that is, if the fmETH contract does not currently hold any ETH as collateral) you can _still_ flash mint an arbitrary amount fmETH and everyone can _still_ safely accept it. And the people who accept it can be _certain_ that they will be able to redeem that fmETH for 1 ETH if they are still holding at the end of the transaction.

This is powerful.

Imagine a flash lending pool with a _literally unlimited_ amount of liquidity available to be borrowed by flash borrowers. And then imagine that the pool did not require anyone to invest their money on the lending side. There are no lenders to pay fees to. There is no need for yield. We are removing lenders from the picture.

Atomic transactions enable traditional flash loans to work because they guarantee the lender that the borrower will repay the loan. The trust comes from the atomicity.

For FMTs, the trust also comes from the atomicity. A holder of an FMT understands that the 1-to-1 peg may become wildly broken during a given transaction, but knows _for sure_ that the 1-to-1 peg will be fully restored by the end of the transaction. If you are holding an FMT, you _will_ be able to redeem it for one of the underlying token at the beginning or end of any external transaction.

FMTs can be thought of as leveraging atomicity to provide a form of _perfect credit_.