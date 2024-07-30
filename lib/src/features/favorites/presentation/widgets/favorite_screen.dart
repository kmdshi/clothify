import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecom_app/core/constants/text_constants.dart';
import 'package:ecom_app/core/presentation/widgets/product_card_widget.dart';
import 'package:ecom_app/src/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:ecom_app/core/presentation/widgets/cheaps_widget.dart';
import 'package:ecom_app/src/features/favorites/presentation/widgets/favorite_products_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../core/constants/assets_path_constants.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FocusNode _node;
  bool _focused = false;

  static const colorizeColors = [
    Colors.black26,
    Colors.white10,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 16.0,
    fontFamily: 'Horizon',
  );
  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(setFocus);
    context.read<FavoriteBloc>().add(InitGetFavoritesProducts());
    super.initState();
  }

  @override
  void dispose() {
    _node.removeListener(setFocus);
    _node.dispose();
    super.dispose();
  }

  void setFocus() {
    setState(() {
      _focused = _node.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(
              TTextConstants.myFavorite,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            centerTitle: true,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Image.asset(
                    TAssetsPath.notificationsIcon,
                    width: 25,
                    height: 25,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: TextField(
                maxLines: 1,
                focusNode: _node,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    width: 15,
                    height: 15,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 18),
                      child: Transform.scale(
                        scale: 5.0,
                        child: Image.asset(
                          color: const Color(0xFF343949),
                          TAssetsPath.searchIcon,
                        ),
                      ),
                    ),
                  ),
                  labelText: 'Search something',
                  labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3), fontSize: 14),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  iconColor: Colors.black,
                  suffixIcon: _focused
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 15,
                          height: 15,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                color: const Color(0xFF343949),
                                TAssetsPath.filterIcon,
                              ),
                            ),
                          ),
                        ),
                  contentPadding:
                      const EdgeInsets.only(left: 40, top: 13, bottom: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black.withOpacity(0.2)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF504DB5),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 18),
              scrollDirection: Axis.horizontal,
              child: CheapsWidget(
                onSelected: (chip) {},
                selectedCheaps: [],
              ),
            ),
          ),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoaded) {
                final favoriteProducts = state.favoriteProducts;
                return favoriteProducts.isNotEmpty
                    ? SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        sliver: AnimationLimiter(
                          child: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final currentProduct = favoriteProducts[index];
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 2,
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: ProductCardWidget(
                                        productEntity: currentProduct,
                                        isFavorite: true,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: favoriteProducts.length,
                            ),
                          ),
                        ),
                      )
                    : SliverFillRemaining(
                        child: Center(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Похоже, здесь пока что пусто...',
                                textStyle: colorizeTextStyle,
                                colors: colorizeColors,
                              ),
                            ],
                          ),
                        ),
                      );
              } else if (state is FavoriteLoading) {
                return const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  sliver: SliverToBoxAdapter(
                    child: FavoriteProductsLoadingWidget(),
                  ),
                );
              } else if (state is FavoriteFailure) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          'Похоже, что-то пошло не так... ${state.message}',
                          textStyle: colorizeTextStyle,
                          colors: colorizeColors,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
