import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/blocs/location_cubit/location_cubit.dart';
import 'package:energise_test_app/localization/generated/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Set<Marker> _markers = {};

  Completer _completer = Completer();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<LocationCubit, LocationState>(
      listener: _locationListener,
      child: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition:
                              const CameraPosition(target: LatLng(0, 0)),
                          markers: _markers,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        LocaleKeys.latLonText.tr(
                          args: [
                            state.location!.lat.toString(),
                            state.location!.lon.toString()
                          ],
                          context: context,
                        ),
                      ),
                      Text(
                        LocaleKeys.cityText.tr(
                          args: [state.location!.city],
                          context: context,
                        ),
                      ),
                      Text(
                        LocaleKeys.countryText.tr(
                          args: [state.location!.country],
                          context: context,
                        ),
                      ),
                      Text(
                        LocaleKeys.timezoneText.tr(
                          args: [state.location!.timezone],
                          context: context,
                        ),
                      ),
                      Text(
                        LocaleKeys.regionText.tr(
                          args: [state.location!.region],
                          context: context,
                        ),
                      ),
                      Text(LocaleKeys.iSPText.tr(
                        args: [state.location!.isp],
                        context: context,
                      )),
                      Text(LocaleKeys.orgText.tr(
                        args: [state.location!.org],
                        context: context,
                      )),
                      Text(LocaleKeys.aSText.tr(
                        args: [state.location!.as],
                        context: context,
                      )),
                      Text(
                        LocaleKeys.queryText.tr(
                          args: [state.location!.query],
                          context: context,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  );
                } else if (state is LocationLoading) {
                  return const CircularProgressIndicator();
                } else if (state is LocationError) {
                  return Text(state.error.toString());
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh(BuildContext context) async {
    context.read<LocationCubit>().getLocation();
    return _completer.future;
  }

  void _locationListener(BuildContext context, LocationState state) async {
    if (state is! LocationLoading) {
      _completer.complete();
      _completer = Completer();
    }

    if (state is LocationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error.toString())),
      );
    } else if (state is LocationLoaded) {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('locationID'),
          position: LatLng(state.location!.lat, state.location!.lon),
          infoWindow: InfoWindow(
            title:
                '${state.location!.city}, ${state.location!.country}, ${state.location!.countryCode}, ${state.location!.region}, ${state.location!.regionName}',
          ),
        ),
      );

      GoogleMapController controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(state.location!.lat, state.location!.lon),
          ),
        ),
      );
    }
  }
}
