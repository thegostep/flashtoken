# crazytown-flash-tokens

"Anyone can be arbitrarily rich, for an instant."
Or
"Borrow all the money in the world. For free."

## Warning

This is a new and completely untested idea. In principle it can let anyone mint and destroy quadrillions of quadrillions of dollars value in an instant. Be careful.

These contracts are simple, but have not been audited. Please don't use them with any amount of money that you don't feel like losing. More importantly, please don't plug these tokens into your platform (e.g. Uniswap, Compound, Maker CDP, etc) unless you've thought much longer and harder about the ramifications than I have.

This is just a fun experiment. Please don't lose any of your hard-earned money.

## What is this?

### The basic boring part

These are tokens that are 1-to-1 backed by some other underlying token. For example, 1 CrazyTownETH (CT-ETH) can be minted by sending the contract 1 ETH. And 1 CT-ETH can be redeemed for 1 ETH by sending it back to the contract.

Simple. No fees. Trustless. Easy. No "pre mine". Etc.

In principle, CrazyTownETH should have a market value approximately equal to that of ETH, because they can be trustlessly redeemed, on demand, for ETH. This should be true no matter how many/few CrazyTown tokens exist.

CrazyTownERC20 works exactly the same, just using your favorite ERC20 token as the underlying token instead of ETH.

### The interesting part

There is a second way that you can mint CrazyTown tokens: Flash Minting. 😎

Anyone can call the `flashMint` function and mint into their account any number of CrazyTown tokens, provided that those tokens are burned before the end of the transaction.

If the hypothesis that "the market will value 1 CrazyTownETH at approximately 1 ETH" holds, then Flash Minting allows anyone to mint an _arbitrary amount of money_ into existence for one "atomic" moment of time.

(In fact, if the market gives them _any value_ greater than `$0` then you can effectively mint an arbitrary amount of value into existence).

No matter what they then do with these tokens (e.g. buy, literally, everything on every DEX, use them as collateral to borrow everything from every lending platform, etc), as long as they are able to burn the correct amount of CrazyTown tokens afterwords, all the accounting on all the platforms should be fine. Nobody is every left holding a bag, because CrazyTown tokens are always 100% backed 1-to-1 before and after a flash loan.

## All the money in the world

You can flash mint as many tokens as you want, provided that the `_totalSupply` never exceeds `2^256-1`. So, for example, if you set DAI to be the underlying for your CrazyTownERC20 (CT-DAI), you could flash mint close to `$2^256 USD` worth of CT-DAI.

If even _one_ major platform listed the CT-DAI token, and it fetched nearly _any_ market price greater `$0`, then you could flash mint enough CT-DAI to leverage the entire power of the entire listing platform towards whatever end you wanted.

Either all of the accounting across all of the platforms you touched during your Flash Mint will balance out correctly, or else your transaction will revert.

## A second warning

Seriously, be careful. This is a new an untested idea and this is unaudited code. Just don't.

For example, I cannot even _imagine_ the tax ramifications of minting and burning `$2^255 USD worth` of CrazyTown tokens.

But have fun and remember: we're all just silly monkeys, and money is just make-believe.