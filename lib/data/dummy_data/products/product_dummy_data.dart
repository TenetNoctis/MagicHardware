import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/models/product_attribute_model.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../features/shop/models/product_variation_model.dart';

class MagicDummyData {
  static final List<ProductModel> products = [
    // Product 1 (Done)
    ProductModel(
      id: '001',
      title: 'Industrial Safety Shoes - EJV',
      stock: 15,
      price: 350,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FSafety%2Fsafety-shoe.png?alt=media&token=9f8f2efc-ed86-4aff-a7c9-1c21b37bdf1b',
      description: 'Industrial Safety Shoes - Vaultex - EJV',
      brand: BrandModel(
        id: '1',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fvaultex.png?alt=media&token=fe9cc2e1-66aa-4910-a859-fdbdf7e8177d',
        name: 'Vaultex',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FSafety%2Fsafety-shoe.png?alt=media&token=9f8f2efc-ed86-4aff-a7c9-1c21b37bdf1b',
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FSafety%2Fsafety-shoe.png?alt=media&token=9f8f2efc-ed86-4aff-a7c9-1c21b37bdf1b',
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FSafety%2Fsafety-shoe.png?alt=media&token=9f8f2efc-ed86-4aff-a7c9-1c21b37bdf1b',
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FSafety%2Fsafety-shoe.png?alt=media&token=9f8f2efc-ed86-4aff-a7c9-1c21b37bdf1b',
      ],
      salePrice: 30,
      sku: 'CCAE00',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black']),
        ProductAttributeModel(
          name: 'Size',
          values: ['no. 38', 'no. 39', 'no. 40', 'no. 41', 'no. 42', 'no. 43'],
        ),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          sku: 'CCAE01',
          stock: 34,
          price: 350,
          salePrice: 122.6,
          image: '',
          description: 'Industrial Safety Shoes - Vaultex - EJV - no. 38.',
          attributeValues: {'Color': 'Black', 'Size': 'no. 38'},
        ),
        ProductVariationModel(
          id: '2',
          sku: 'CCAE02',
          stock: 15,
          price: 350,
          image: '',
          attributeValues: {'Color': 'Black', 'Size': 'no. 39'},
        ),
        ProductVariationModel(
          id: '3',
          sku: 'CCAE03',
          stock: 0,
          price: 350,
          image: '',
          attributeValues: {'Color': 'Black', 'Size': 'no. 40'},
        ),
        ProductVariationModel(
          id: '4',
          sku: 'CCAE04',
          stock: 222,
          price: 350,
          image: '',
          attributeValues: {'Color': 'Black', 'Size': 'no. 41'},
        ),
        ProductVariationModel(
          id: '5',
          sku: 'CCAE05',
          stock: 0,
          price: 350,
          image: '',
          attributeValues: {'Color': 'Black', 'Size': 'no. 42'},
        ),
        ProductVariationModel(
          id: '6',
          sku: 'CCAE06',
          stock: 11,
          price: 350,
          image: '',
          attributeValues: {'Color': 'Black', 'Size': 'no. 43'},
        ),
      ],
      productType: 'ProductType.variable',
    ),

    // Product 2 (Done)
    ProductModel(
      id: '002',
      title: 'TIG Welding Glove - Round thumb',
      stock: 15,
      price: 85,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FWelding%2Fwelding-glove.png?alt=media&token=fe76c886-d77a-412c-afd1-2f4f132728f2',
      description:
          'This is a Product description for TIG Welding Glove - Round thumb.',
      brand: BrandModel(
        id: '1',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fvaultex.png?alt=media&token=fe9cc2e1-66aa-4910-a859-fdbdf7e8177d',
        name: 'Vaultex',
        productsCount: 265,
        isFeatured: true,
      ),
      images: [
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FWelding%2Fwelding-glove.png?alt=media&token=fe76c886-d77a-412c-afd1-2f4f132728f2',
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FWelding%2Fwelding-glove.png?alt=media&token=fe76c886-d77a-412c-afd1-2f4f132728f2',
        'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FWelding%2Fwelding-glove.png?alt=media&token=fe76c886-d77a-412c-afd1-2f4f132728f2',
      ],
      salePrice: 80,
      sku: 'COAD08',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['Free Size']),
        ProductAttributeModel(name: 'Color', values: ['Grey']),
      ],
      productType: 'ProductType.single',
    ),

    // Product 3 (Done)
    ProductModel(
      id: '003',
      title: 'Crimping Tool 16" - 1.5 to 16mm',
      stock: 15,
      price: 550,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FTools%2Fcrimping-tool.png?alt=media&token=bb6f9286-33a7-40fd-bd12-fbdd57019ac3',
      description: 'Crimping Tool 16" 1.5 to 16mm',
      brand: BrandModel(
        id: '2',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fuken.png?alt=media&token=29b21a45-c2ae-4c3a-9dc5-dded5b1edc3b',
        name: 'Uken',
      ),
      salePrice: 500,
      sku: 'CJAW16',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Yellow']),
      ],
      productType: 'ProductType.single',
    ),

    // Product 4 (Done)
    ProductModel(
      id: '004',
      title: 'Paint Roller - Uken',
      stock: 15,
      price: 55,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FPainting%2Fpaint-roller.png?alt=media&token=42f5c45b-78e7-419e-8fb9-21205a5ccc4c',
      description: 'Paint Roller - Uken',
      brand: BrandModel(
        id: '2',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fuken.png?alt=media&token=29b21a45-c2ae-4c3a-9dc5-dded5b1edc3b',
        name: 'Uken',
      ),
      salePrice: 50,
      sku: 'BSAE07',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['9"']),
        ProductAttributeModel(name: 'Color', values: ['Blue']),
      ],
      productType: 'ProductType.single',
    ),

    // Product 5 (Done)
    ProductModel(
      id: '005',
      title: 'Fan Dimmer - Honeywell',
      stock: 15,
      price: 190,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FElectric%2Ffan-dimmer.png?alt=media&token=0d8a877d-6815-4efa-8fda-eb9cb5d59308',
      description: 'This is a Product description for Fan Dimmer - Honeywell.',
      brand: BrandModel(
        id: '3',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fhoneywell.png?alt=media&token=2275d036-60fc-48da-abdd-e934311c72ee',
        name: 'Honeywell',
      ),
      sku: 'AXAN13',
      categoryId: '5',
      productType: 'ProductType.single',
    ),

    // Product 6 (Done)
    ProductModel(
      id: '006',
      title: 'TIG Welding Machine - EDON - 300A',
      stock: 15,
      price: 10000,
      isFeatured: true,
      thumbnail:
          'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FProducts%2FMachinery%2Fwelding-machine.png?alt=media&token=b60c0aa0-af78-40ce-a7c1-b2d211c336bc',
      description:
          'This is a Product description for TIG Welding Machine - EDON - 300A.',
      brand: BrandModel(
        id: '4',
        image:
            'https://firebasestorage.googleapis.com/v0/b/magic-hardware-mobile-app.firebasestorage.app/o/Assets%2FImages%2FBrands%2Fedon.png?alt=media&token=94cc4266-9110-44c0-be03-7740db34770b',
        name: 'Edon',
      ),
      salePrice: 9500,
      sku: 'CMAD02',
      categoryId: '6',
      productType: 'ProductType.single',
    ),
  ];
}
