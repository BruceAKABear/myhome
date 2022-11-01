## MyHome Protocol

in order to control devices or read data from the device we must to define a serials protocol for
our platform.the protocol inclouds two different parts,

the communication part and the payload part.

## communication protocol

## payload protocol

I think the json style data is the most popular protocol in this time, so , in MyHome system the
payload protocol is json.
how to understand it?

> examples: if you have one switch device, and in the firmware just process one symbol "open",when
> open=true the switch on and
> when open=false the switch off.so the payload MyHome send to the device is like below:
> status on:

```json
{
  "open": true
}
```

> status off:

```json
{
  "open": false
}
```

