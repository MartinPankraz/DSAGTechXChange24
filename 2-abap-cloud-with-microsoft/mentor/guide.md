# Mentor Guide

ABAP Cloud language settings influence how the ABAP code is interpreted and what functions/objects are permitted to be used.

> [!IMPORTANT]
> Pay special attention to the settings `strict ( 2 );` on SAP RAP behavior definition objects. Consider lowering the strictness level to `strict ( 1 );` if you are getting errors during the development process.

Be aware of the extension contract levels of ABAP Cloud Objects and their API state. Using C1 legacy objects can be called from wrapper classes. Have a look [here](https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/cef1ada754154d11b5701ab60e6ab412.html) for more details.
