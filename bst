#include <stdlib.h>

/* Structure of a node */
struct Node {
    int data;
    struct Node *left;
    struct Node *right;
};

/* Create a new node */
struct Node* createNode(int value) {
    struct Node *newNode;

    newNode = (struct Node*)malloc(sizeof(struct Node));

    newNode->data = value;
    newNode->left = NULL;
    newNode->right = NULL;

    return newNode;
}

/* Insert a node into BST */
struct Node* insert(struct Node* root, int value) {

    /* If tree is empty, create a new node */
    if (root == NULL) {
        return createNode(value);
    }

    /* Insert in left subtree */
    if (value < root->data) {
        root->left = insert(root->left, value);
    }

    /* Insert in right subtree */
    else if (value > root->data) {
        root->right = insert(root->right, value);
    }

    return root;
}

/* Search a node */
struct Node* search(struct Node* root, int value) {

    /* Value not found */
    if (root == NULL) {
        return NULL;
    }

    /* Value found */
    if (root->data == value) {
        return root;
    }

    /* Search in left subtree */
    if (value < root->data) {
        return search(root->left, value);
    }

    /* Search in right subtree */
    return search(root->right, value);
}

/* Find minimum node */
struct Node* findMin(struct Node* root) {

    while (root->left != NULL) {
        root = root->left;
    }

    return root;
}

/* Delete a node */
struct Node* deleteNode(struct Node* root, int value) {

    if (root == NULL) {
        return root;
    }

    /* Search in left subtree */
    if (value < root->data) {
        root->left = deleteNode(root->left, value);
    }

    /* Search in right subtree */
    else if (value > root->data) {
        root->right = deleteNode(root->right, value);
    }

    /* Node found */
    else {

        /* Case 1: No child */
        if (root->left == NULL && root->right == NULL) {
            free(root);
            return NULL;
        }

        /* Case 2: Only right child */
        else if (root->left == NULL) {
            struct Node *temp = root->right;
            free(root);
            return temp;
        }

        /* Case 3: Only left child */
        else if (root->right == NULL) {
            struct Node *temp = root->left;
            free(root);
            return temp;
        }

        /* Case 4: Two children */
        else {
            struct Node *temp = findMin(root->right);

            root->data = temp->data;

            root->right = deleteNode(root->right, temp->data);
        }
    }

    return root;
}

/* Inorder: Left -> Root -> Right */
void inorder(struct Node* root) {

    if (root != NULL) {
        inorder(root->left);
        printf("%d ", root->data);
        inorder(root->right);
    }
}

/* Preorder: Root -> Left -> Right */
void preorder(struct Node* root) {

    if (root != NULL) {
        printf("%d ", root->data);
        preorder(root->left);
        preorder(root->right);
    }
}

/* Postorder: Left -> Right -> Root */
void postorder(struct Node* root) {

    if (root != NULL) {
        postorder(root->left);
        postorder(root->right);
        printf("%d ", root->data);
    }
}

/* Main function */
int main() {

    struct Node *root = NULL;
    struct Node *result;
    int choice, value;

    while (1) {

        printf("\n\n===== BINARY SEARCH TREE =====\n");
        printf("1. Insert\n");
        printf("2. Search\n");
        printf("3. Delete\n");
        printf("4. Inorder Traversal\n");
        printf("5. Preorder Traversal\n");
        printf("6. Postorder Traversal\n");
        printf("7. Exit\n");

        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {

            case 1:
                printf("Enter value: ");
                scanf("%d", &value);

                root = insert(root, value);

                printf("Node inserted successfully.\n");
                break;

            case 2:
                printf("Enter value to search: ");
                scanf("%d", &value);

                result = search(root, value);

                if (result != NULL)
                    printf("Value %d found.\n", value);
                else
                    printf("Value %d not found.\n", value);

                break;

            case 3:
                printf("Enter value to delete: ");
                scanf("%d", &value);

                if (search(root, value) != NULL) {
                    root = deleteNode(root, value);
                    printf("Value %d deleted.\n", value);
                }
                else {
                    printf("Value %d not found.\n", value);
                }

                break;

            case 4:
                printf("Inorder: ");
                inorder(root);
                printf("\n");
                break;

            case 5:
                printf("Preorder: ");
                preorder(root);
                printf("\n");
                break;

            case 6:
                printf("Postorder: ");
                postorder(root);
                printf("\n");
                break;

            case 7:
                printf("Program ended.\n");
                exit(0);

            default:
                printf("Invalid choice!\n");
        }
    }

    return 0;
}
