import random
from faker import Faker
from backend.extensions import db
from backend.models import Product, Category, Attribute, ProductAttributeValue, ProductImage, Store
from app import create_app

fake = Faker()

app = create_app()

NUM_CATEGORIES = 10
NUM_ATTRIBUTES = 10
NUM_PRODUCTS = 100

with app.app_context():
    # Verificar o crear tienda con ID 1
    store = Store.query.get(1)
    if not store:
        store = Store(id=1, name=fake.company(), address=fake.address())
        db.session.add(store)
        db.session.commit()
        print("Tienda creada con ID 1.")

    # Crear categorías
    categories = []
    for _ in range(NUM_CATEGORIES):
        name = fake.unique.word().capitalize()
        category = Category(name=name, description=fake.text())
        db.session.add(category)
        categories.append(category)
    db.session.commit()

    # Crear atributos
    attributes = []
    for _ in range(NUM_ATTRIBUTES):
        name = fake.unique.word().capitalize()
        attribute = Attribute(name=name)
        db.session.add(attribute)
        attributes.append(attribute)
    db.session.commit()

    # Crear productos
    for _ in range(NUM_PRODUCTS):
        category = random.choice(categories)
        name = fake.unique.company()
        description = fake.text(max_nb_chars=200)
        sale_price = round(random.uniform(10.0, 100.0), 2)
        purchase_price = round(sale_price * 0.7, 2)
        stock = random.randint(0, 100)

        product = Product(
            name=name,
            description=description,
            sale_price=sale_price,
            purchase_price=purchase_price,
            stock=stock,
            category_id=category.id,
            store_id=store.id
        )
        db.session.add(product)
        db.session.flush()  # Para obtener el ID del producto

        # Agregar imágenes
        for _ in range(random.randint(1, 3)):
            image = ProductImage(
                product_id=product.id,
                url=fake.image_url()
            )
            db.session.add(image)

        # Agregar atributos
        selected_attributes = random.sample(attributes, random.randint(1, len(attributes)))
        for attr in selected_attributes:
            pav = ProductAttributeValue(
                product_id=product.id,
                attribute_id=attr.id,
                value=fake.word()
            )
            db.session.add(pav)

    db.session.commit()

print(f"{NUM_PRODUCTS} productos generados con éxito.")
