DocBlock
=======

Our standard for writing comments, from PHPDoc and phpDocumentor.

* `@todo` is used for todos that can wait, `@TODO` is for todos that need doing before launching.
* Your name is one parameter and does not need formatting.
* `$param` and `$return` are in the format `type` `variable` `description`, separated by spacing so they line up.
* When using objects, ideally lise the namespace and class.

Comments should be written in plain English without jargon. 

```php
	/**
	 * Updates an invoice
	 *
	 * Returns a redirect to the invoice view.
	 *
	 * @author John Smith <john.smith@wearearchitect.com>
	 * @param  object   Invoice $invoice  Customer\Invoice instance
	 * @return object                     Redirect to invoice view
	 */
	function update(Invoice $invoice)
	{
		$invoice = $this->repo->update($invoice);

		return Redirect::route('invoice', ['invoice' => $invoice->id]);
	}
```
