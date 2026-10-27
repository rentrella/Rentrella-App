import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/app_banner.dart';
import 'package:rentrella/core/widgets/app_divider.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';
import 'package:rentrella/core/widgets/dialog/inquiry_dialog.dart';
import 'package:rentrella/feature/home/bloc/home_bloc.dart';
import 'package:rentrella/feature/home/presentation/widgets/home_icon_button.dart';
import 'package:rentrella/core/widgets/buttons/app_sub_button.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_state_card.dart';
import 'package:rentrella/feature/home/presentation/widgets/umbrella_card.dart';
import 'package:rentrella/feature/home/presentation/widgets/weather_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        umbrellaRepository: context.read(),
        weatherRepository: context.read(),
      )..add(const HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late final _hdElevation = _ScrollElevationController(
    onUpdate: () => setState(() {}),
  );

  @override
  void initState() {
    super.initState();
    _hdElevation.init();
  }

  @override
  void dispose() {
    _hdElevation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final weather = state.weather;

    return BaseScaffold(
      backgroundColor: AppColors.white,
      appBar: AppBanner(
        suffix: const _Profile(),
        emphasis: !_hdElevation.emphasis,
      ),
      body: CustomScrollView(
        controller: _hdElevation.sc,
        key: _hdElevation.scKey,
        slivers: [
          SliverToBoxAdapter(child: AppSpacing.s24.gapH),

          SliverPadding(
            padding: .symmetric(horizontal: AppSpacing.s16),
            sliver: SliverToBoxAdapter(
              child: weather == null
                  ? SizedBox(height: AppSize.s120)
                  : WeatherBanner(
                      status: weather.status,
                      available: state.availableCount > 0,
                      temperature: weather.temperature,
                      totalPerEnables: (
                        total: state.total,
                        enables: state.availableCount,
                      ),
                    ),
            ),
          ),

          SliverToBoxAdapter(child: AppSpacing.s24.gapH),

          SliverPadding(
            padding: .symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s8,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: AppSpacing.s8,
                children: [
                  AppDivider(pad: .all(AppSpacing.s8)),
                  const UmbrellaStateCard.ready(),
                  AppDivider(pad: .all(AppSpacing.s8)),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: AppSpacing.s16.gapH),

          PinnedHeaderSliver(
            child: AnimatedContainer(
              key: _hdElevation.hdKey,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: _hdElevation.emphasis
                    ? const [AppShadow.button]
                    : null,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s8,
              ),
              child: Row(
                children: [
                  Text(
                    '우산 목록',
                    style: AppTextStyle.title3.copyWith(
                      color: AppColors.subD_2,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '총 ${state.total}개 중 ${state.availableCount}개 가능',
                    style: AppTextStyle.content2.copyWith(
                      color: AppColors.subD_3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: .symmetric(horizontal: AppSpacing.s16),
            sliver: SliverGrid.builder(
              itemBuilder: (context, index) {
                final item = state.umbrellas[index];
                final bloc = context.read<HomeBloc>();
                return UmbrellaCard.formMode(
                  item,
                  onBorrow: () => bloc.add(HomeUmbrellaBorrowed(item.id)),
                  onReturn: () => bloc.add(HomeUmbrellaReturned(item.id)),
                );
              },
              itemCount: state.umbrellas.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.s8,
                mainAxisSpacing: AppSpacing.s8,
              ),
            ),
          ),

          SliverToBoxAdapter(child: AppSpacing.s24.gapH),
        ],
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('{이름}님', style: AppTextStyle.content1),
            Text('환영합니다', style: AppTextStyle.content5),

            AppSpacing.s8.gapH,

            Row(
              spacing: AppSpacing.s4,
              children: [
                AppSubButton(
                  label: '문의하기',
                  icon: .bubbleChat,
                  onPressed: () => InquiryDialog.show(context),
                ),
                AppSubButton(
                  label: '"마이페이지"로 이동',
                  icon: .personOutline,
                  onPressed: () {
                    context.pushNamed(AppRoutes.accountAndSetting.name);
                  },
                ),
              ],
            ),
          ],
        ),

        AppSize.s12.gapW,

        HomeIconButton(onPressed: () {}, icon: .bell),
      ],
    );
  }
}

class _ScrollElevationController {
  _ScrollElevationController({required this._onUpdate});

  final VoidCallback _onUpdate;

  final ScrollController sc = ScrollController();
  final GlobalKey scKey = GlobalKey();
  final GlobalKey hdKey = GlobalKey();

  double? _threshold;
  bool emphasis = false;

  void init() {
    sc.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback(_measureThreshold);
  }

  void dispose() => sc.dispose();

  void _measureThreshold(_) {
    final scBox = scKey.currentContext?.findRenderObject() as RenderBox?;
    final hdBox = hdKey.currentContext?.findRenderObject() as RenderBox?;
    if (scBox == null || hdBox == null) return;
    _threshold = hdBox.localToGlobal(.zero).dy - scBox.localToGlobal(.zero).dy;
  }

  void _onScroll() {
    if (_threshold == null) return;
    final over = sc.offset > _threshold!;
    if (over != emphasis) {
      emphasis = over;
      _onUpdate();
    }
  }
}
