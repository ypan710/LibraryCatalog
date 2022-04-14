pragma solidity >= 0.7.0 < 0.9.0;

contract Library {
    
    event AddBook(address recipient, uint bookId);
    event SetFinished(uint bookId, bool finished);

    struct Book {
        uint id;
        string name;
        uint year;
        string author;
        bool finished;
    }

    Book[] private bookList;

    // mapping of book id to address of book user 
    // when adding a new book to their name
    mapping (uint256 => address) bookToOwner;

    function addBook(string memory name, uint16 year, string memory author, bool finished) external {
        uint bookId = bookList.length;
        bookList.push(Book(bookId, name, year, author, finished));
        bookToOwner[bookId] = msg.sender;
        emit AddBook(msg.sender, bookId);
    }

    // return a list of books that have been finished or unfinished
    function _getBookList(bool finished) private view returns (Book[] memory) {
        Book[] memory temporary = new Book[](bookList.length);
        uint counter = 0;
        for (uint i = 0; i < bookList.length; i++) {
            // check if the deployer of contract is a book owner
            if (bookToOwner[i] == msg.sender && bookList[i].finished == finished){
                temporary[counter] = bookList[i]; // keep storing books
                counter++;
            }
        }

        // minimize the list of books finished or unfinished
        Book[] memory result = new Book[](counter);
        for (uint i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }

        return result;
    }

    // return a list of unfinished books
    function getUnfinishedBooks() external view returns (Book[] memory) {
        return _getBookList(false);
    }

    // return a list of finished books
    function getFinishedBooks() external view returns (Book[] memory) {
        return _getBookList(true);
    }

    // set finished status for reading a book
    function setFinished(uint bookId, bool finished) external {
        if (bookToOwner[bookId] == msg.sender) {
            bookList[bookId].finished = finished;
            emit SetFinished(bookId, finished);
        }
    }
}
