public class HashEntry {

	private int key;
	private int value;

	HashEntry(int key, int value) {
		this.key = key;
		this.value = value;
	}

	public int getKey() {
		return key;
	}

	public int getValue() {
		return value;
	}
}

public class HashMap {

	private final static int TABLE_SIZE = 128;

	private HashEntry table[];

	HashMap() {
		table = new HashEntry[TABLE_SIZE];
		for (int i = 0; i < table.length; i++)
			table[i] = null;
	}

	public int get(int key) {
		hash = (key % TABLE_SIZE);

		while (table[hash] != null && table[hash].getKey() != key)
			hash = (hash + 1) % TABLE_SIZE;

		if (table[hash] == null)
			return -1;
		else
			return table[hash].getValue();
	}

	public int put(int key, int value) {
		hash = (key % TABLE_SIZE);

		while (table[hash] != null && table[hash].getKey() != key)
			hash = (hash + 1) % TABLE_SIZE;

		table[hash] = new HashEntry(key, value);
	}


}