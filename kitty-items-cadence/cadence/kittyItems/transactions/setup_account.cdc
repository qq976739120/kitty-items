import NonFungibleToken from 0xNONFUNGIBLETOKEN
import KittyItems from 0xKITTYITEMS
// This transaction is what an account would run
// to set itself up to receive NFTs

transaction {
    prepare(acct: AuthAccount) {

        // If the account doesn't already have a collection
        if acct.borrow<&KittyItems.Collection>(from: /storage/KittyItemsCollection) == nil {

            // Create a new empty collection
            let collection <- KittyItems.createEmptyCollection() as! @KittyItems.Collection
            
            // save it to the account
            acct.save(<-collection, to: /storage/KittyItemsCollection)

            // create a public capability for the collection
            acct.link<&{NonFungibleToken.CollectionPublic}>(/public/KittyItemsCollection, target: /storage/KittyItemsCollection)
        }
    }
}